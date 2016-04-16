#! /usr/bin python
from sqlalchemy import (
    Boolean,
    Column,
    Integer,
    String,
    Float,
    TEXT
)
from database import Base


class Batch(Base):

    __tablename__ = 'batch'
    __table_args__ = {'schema': 'src'}

    batch_id = Column(Integer, primary_key=True)
    datasource_id = Column(Integer)
    name = Column(String())
    is_active = Column(Boolean)

    def __init__(self,
                 datasource_id=None,
                 name=None,
                 is_active=None):

        self.datasource_id = datasource_id
        self.name = name
        self.is_active = is_active


class JobsData(Base):

    __tablename__ = 'jobs_data'
    __table_args__ = {'schema': 'src'}

    jobs_data_id = Column(Integer, primary_key=True)
    batch_id = Column(Integer)
    category_id = Column(Float)
    numJobs = Column(Integer)
    name = Column(String())
    stateAbbreviation = Column(String(2))
    stateName = Column(String())
    id = Column(Integer)
    latitude = Column(Float)
    longitude = Column(Float)

    def __init__(self,
                 batch_id=None,
                 numJobs=None,
                 name=None,
                 stateAbbreviation=None,
                 stateName=None,
                 id=None,
                 latitude=None,
                 longitude=None,
                 category_id=None):

        self.batch_id = batch_id
        self.numJobs = numJobs
        self.name = name
        self.stateAbbreviation = stateAbbreviation
        self.stateName = stateName
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.category_id = category_id

def __repr__(self):
        return '<city-state: %s, %s>' % (self.city, self.state)
