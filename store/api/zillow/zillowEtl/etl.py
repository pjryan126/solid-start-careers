from time import strftime
import StringIO
import os
import Quandl
from database import db_session
from models import Batch, City, HomeValue

def get_home_values(code):
    print "getting home values"
    dataset = 'ZILL'
    token = 'sWyovn27HuCobNWR2'
    try:
        import time
        time.sleep(.35)
        data = Quandl.get('%s/C%s_A' % (dataset, code), authtoken=token)
    except:
        import time
        time.sleep(.35)
        data = Quandl.get('%s/C%s_A' % (dataset, code))

    data.index.name = 'Date'
    data.reset_index(inplace=True)

    return data

def push_to_hadoop(data, batch_name):
    s = StringIO.StringIO()
    data.to_csv(s)
    os.system('sudo -u w205 hdfs dfs -mkdir -p /user/w205/src/housing_data')
    cmd = 'echo "%s" | sudo -u w205 hdfs dfs -put ' \
          '/user/w205/src/housing_data/%s'
    os.system(cmd % (s, batch_name))
    return

def push_to_sql(data, code, batch_id):
    print "push_to_sql: %s" % code
    for i, d in data.iterrows():
        h = HomeValue()
        h.batch_id = batch_id
        h.city_code = code
        h.valuation_date = d['Date']
        h.median_value = d['Value']
        db_session.add(h)
        if i % 1000 == 0:
            db_session.flush()
    db_session.commit()
    return

def main():
    today = strftime('%Y%m%d')
    batch_name = 'Median_Home_Values_Data_%s.csv' % today

    # Mark all current jobs_data batches inactive
    db_session.query(Batch).filter_by(datasource_id=5).update({'is_active': False})
    batch = Batch(datasource_id=5, name=batch_name, is_active=True)
    db_session.add(batch)
    db_session.flush()
    db_session.commit()

    cities = db_session.query(City).order_by(City.code)
    for city in cities:
        print "city: %s" % city.code
        data = get_home_values(city.code)
        push_to_hadoop(data, batch_name)
        push_to_sql(data, city.code, batch.batch_id)

if __name__ == '__main__':
    main()
