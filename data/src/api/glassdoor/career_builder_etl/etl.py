#! /usr/bin/python

from collections import OrderedDict
from time import strftime
import os

import requests

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
        fpath = os.path.join(dirpath, 'data')
        f = '%s_%s.txt' % (category, today)
        with open(os.path.join(fpath, f), 'w') as outfile:
            outfile.write(response.content)

    except requests.exceptions.RequestException as e:
        log_error()

    return



def main():
    categories = range(1, 34)
    for c in categories:
        get_job_stats(c)

if __name__=='__main__':
    main()