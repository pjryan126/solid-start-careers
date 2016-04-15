#! /usr/bin python
from sqlalchemy import Column, Integer, String, Float, TEXT
from database import Base

class JobsData(Base):
    __tablename__ = 'jobs_data'
    __table_args__ = {'schema': 'src'}

    jobs_data_id = Column(Integer, primary_key=True)
    numJobs = Column(String())
    name = Column(String())
    stateAbbreviation = Column(String())
    stateName = Column(String())
    id = Column(String())
    latitude = Column(String())
    longitude = Column(String())
    category_id = Column(String())

    def __init__(self,
                 num_jobs=None,
                 city=None,
                 state=None,
                 source_id=None,
                 latitude=None,
                 longitude=None):

        self.num_jobs = num_jobs
        self.city = city
        self.state = state
        self.source_id = source_id
        self.latitude = latitude
        self.longitude = longitude

    def __repr__(self):
        return '<city-state: %s, %s>' % (self.city, self.state)