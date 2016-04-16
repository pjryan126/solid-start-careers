#! /usr/bin python

from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker
from sqlalchemy.ext.declarative import declarative_base

# build db_uri
db_uri = 'postgresql://postgres:password@' \
         'ec2-54-152-192-253.compute-1.amazonaws.com:5432/' \
         'solid_start_test'

engine = create_engine(db_uri, convert_unicode=True)
db_session = scoped_session(sessionmaker(autocommit=False,
                                         autoflush=False,
                                         bind=engine))
Base = declarative_base()
Base.query = db_session.query_property()

def init_db():
    from models import JobsData
    Base.metadata.create_all(bind=engine)
