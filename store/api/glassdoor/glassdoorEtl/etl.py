#! /usr/bin/python

from collections import OrderedDict
import csv
import json
from time import strftime
import os
import requests
import psycopg2


def call_api(action, category=None):
    # base url for glassdoor api
    url_gd = 'http://api.glassdoor.com/api/api.htm'

    # request params for api call
    params_gd = OrderedDict({
        'v': '1',
        'format': 'json',
        't.p': '57562',
        't.k': 'kCsOFi8tlzo',
        'userip': '0.0.0.0',
        'useragent': 'Mozilla/5.0 (X11; Linux x86_64)'
                     'AppleWebKit/537.36 (KHTML, like Gecko)'
                     'Chrome/43.0.2357.81'
                     'Safari/537.36',
        'action': action,
        'returnStates': 'true',
        'admLevelRequested': '1',
        'returnCities': 'true',
    })

    # add category, if provided, to request params
    if category is not None:
        params_gd['jc'] = str(category)

    # send request
    r = requests.get(url_gd, params=params_gd,
                        headers={'User-Agent': params_gd['useragent']})

    return r

def get_job_stats(category=None):

    dirpath = os.path.dirname(os.path.realpath(__file__))
    today = strftime('%Y%m%d')

    # Log error if request is unsuccessful
    def log_error():
        fpath = os.path.join(dirpath, 'logs')
        f = 'errlog_%s.txt' % today
        with open(os.path.join(fpath, f), 'a') as outfile:
            outfile.write('Error: Unexpected response {}'.format(response))
        return

    try:
        response = call_api('jobs-stats', category=category)
        # Consider any status other than 2xx an error
        if not response.status_code // 100 == 2:
            log_error()
            return

    except requests.exceptions.RequestException as e:
        log_error()
    return json.loads(response.content, object_pairs_hook=OrderedDict)

def parse_to_csv(data, category):

    def parse_row(d, c):
        d.update({'category_id': c})
        # iterate over the key/values pairings
        for k, v in d.items():
            if v == u'Wahiaw\xe4, HI':
                d[k] = u'Wahiawa, HI'
            if isinstance(v, str):
                d[k] = ''.join([i if ord(i) < 128 else ' ' for i in text])

        return d

    dirpath = os.path.dirname(os.path.realpath(__file__))
    today = strftime('%Y%m%d')
    fpath = os.path.join(dirpath, 'csv')
    f = os.path.join(fpath, '%s_%s.csv' % (category, today))
    data = data['response']['cities']
    items = [parse_row(d, category) for d in data if d is not None]
    with open(f, 'wb') as outfile:
        dict_writer = csv.DictWriter(outfile, items[0].keys())
        dict_writer.writeheader()
        dict_writer.writerows(items)
    return f

def push_to_sql(csv_file):

    db_uri = 'postgresql://postgres:password@' \
         'ec2-54-152-192-253.compute-1.amazonaws.com:5432/' \
         'solid_start_test'

    conn = psycopg2.connect(db_uri)
    cur = conn.cursor()
    copy_sql = """
               COPY raw.jobs_data FROM stdin
               WITH DELIMITER AS ','
               CSV HEADER QUOTE AS '"'
               """

    with open(csv_file, 'r') as f:
        cur.copy_expert(sql=copy_sql, file=f)
        #cur.execute('DELETE FROM raw.jobs_data;')
        conn.commit()
        cur.close()
    return

def main():
    categories = range(1, 34)
    for c in categories:
        data = get_job_stats(c)
        csv_file = parse_to_csv(data, c)
        push_to_sql(csv_file)
        #push_to_hadoop(data)

if __name__=='__main__':
    main()