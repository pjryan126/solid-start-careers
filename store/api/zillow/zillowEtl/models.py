#! /usr/bin python
from sqlalchemy import (
    Boolean,
    Column,
    Date,
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


class City(Base):
    __tablename__ = 'city_data'
    __table_args__ = {'schema': 'src'}

    city_id = Column(Integer, primary_key=True)
    batch_id = Column(Integer)
    code = Column(String())
    region = Column(String())
    state = Column(String())
    metro = Column(String())
    county = Column(String())


class HomeValue(Base):

    __tablename__ = 'median_home_value'
    __table_args__ = {'schema': 'src'}

    median_home_value_id = Column(Integer, primary_key=True)
    batch_id = Column(Integer)
    city_code = Column(String())
    valuation_date = Column(Date)
    median_value = Column(Float)

