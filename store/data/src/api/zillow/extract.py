import json
from multiprocessing import Pool, Manager
import os
import requests
import Quandl as quandl

# set working directory to script directory.
abspath = os.path.abspath(__file__)
dname = os.path.dirname(abspath)
os.chdir(dname)

errors = []

def get_url(url, vars=None):

	if vars is not None:
		var_string = '?'
		for key, value in vars.items():
			var_string += '{0}={1}&'.format(key, value)
		var_string = var_string[:-1]
		url += var_string
	return {'url': url, 'page': vars['page']}

def get_csv(url):
	results = requests.get(url['url'])
	fname = os.path.join(dname, 'meta/zhv_index/{0}.csv'.format(url['page']))
	print(fname)
	with open(fname, 'w') as f:
		for d in results['datasets']:
			f.write(l + '\n')


	return
			
def main():
	requests = []
	url = 'https://www.quandl.com/api/v3/datasets.csv'
	for i in range(1, 12663):
		vars = {'database_code': 'ZILL',
				'per_page': '100',
				'sort_by': 'id',
				'page': str(i),
				'api_key': 'sWyovn27HuCobNWR2xyz'}
		requests.append(dict(url=get_url(url, vars), id=str(i))

	pool = Pool(8)
	pool.map(get_csv, urls)
	pool.close() 
	pool.join()

	print('Errors: ' + errors)
if __name__ == '__main__':
	main()




