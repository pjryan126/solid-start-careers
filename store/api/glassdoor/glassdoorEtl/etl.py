#! /usr/bin/python

from collections import OrderedDict
import csv
import json
from time import strftime
import os
import requests

from database import db_session
from models import Batch, JobsData


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
    return json.loads(response.content)

def push_to_hadoop(data, batch_name, category):
    os.system('sudo -u w205 hdfs dfs -mkdir /user/w205/src/jobs_data')
    cmd = 'echo "%s" | sudo -u w205 hdfs dfs -put ' \
          '/user/w205/src/jobs_data/%s_%s.txt'
    print 'executing: %s' % cmd
    os.system( cmd % (json.dump(data), batch_name, category))
    return

def push_to_sql(data, batch_id, category):

    def parse_data(d):
    # iterate over the key/values pairings
    for k, v in d.items():
        if v == u'Wahiaw\xe4, HI':
            d[k] = u'Wahiawa, HI'
        if isinstance(v, str):
            d[k] = ''.join([i if ord(i) < 128 else ' ' for i in text])
    return d

    for i, d in enumerate(data):
        d = parse_data(d)
        j = JobsData()

        j.batch_id = batch_id
        j.category_id = category
        j.numJobs = d['numJobs']
        j.name = d['name']
        j.stateAbbreviation = d['stateAbbreviation']
        j.stateName = d['stateName']
        j.id = d['id']
        j.latitude = d['latitude']
        j.longitude = d['longitude']

        db_session.add(j)
        if i % 1000 == 0:
            db_session.flush()
    db_session.commit()
    return

def main():
    today = strftime('%Y%m%d')
    batch_name = 'Jobs_Data_%s.csv' % today

    # Mark all current jobs_data batches inactive
    db_session.query(Batch).filter_by(datasource_id=6).update({'is_active': False})
    batch = Batch(datasource_id=6, name=batch_name, is_active=True)
    db_session.add(batch)
    db_session.flush()
    db_session.commit()

    categories = range(1, 34)
    for c in categories:
        print "processing category %s" % c
        data = get_job_stats(c)
        #push_to_hadoop(data, batch_name, c)
        push_to_sql(data['response']['cities'], batch.batch_id, c)

    db_session.close()

if __name__ == '__main__':
    main()
