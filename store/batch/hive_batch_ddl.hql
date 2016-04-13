CREATE SCHEMA IF NOT EXISTS src;

-- create crime stats source table
DROP TABLE IF EXISTS src.crime_stats;
CREATE EXTERNAL TABLE IF NOT EXISTS src.crime_stats (
year STRING,
population STRING,
violent_crime_rate STRING,
homicide_rate STRING,
rape_rate STRING,
robbery_rate STRING,
aggr_assault_rate STRING,
property_crime_rate STRING,
burglary_rate STRING,
larceny_theft_rate STRING,
auto_theft_rate STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ","
, "quoteChar" = '"'
, "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/src/crime_by_state'
TBLPROPERTIES ("skip.header.line.count"="1");

-- create park score source table
DROP TABLE IF EXISTS src.park_score;
CREATE TABLE IF NOT EXISTS src.park_score (
city STRING, 
state STRING,
year STRING,
score STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ","
, "quoteChar" = '"'
, "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/src/park_score'
TBLPROPERTIES ("skip.header.line.count"="1");

--create quality of life source table
DROP TABLE IF EXISTS src.quality_of_life;
CREATE EXTERNAL TABLE IF NOT EXISTS src.quality_of_life (
Year STRING,
LocationAbbr STRING,
LocationDesc STRING,
Category STRING,
Topic STRING,
Question STRING,
DataSource STRING,
Data_Value_Unit STRING,
Data_Value_Type STRING,
Data_Value STRING,
Data_Value_Footnote_Symbol STRING,
Data_Value_Footnote STRING,
Data_Value_Std_Err STRING,
Low_Confidence_Limit STRING,
High_Confidence_Limit STRING,
Sample_Size STRING,
Break_Out STRING,
Break_Out_Category STRING,
GeoLocation STRING,
CategoryId STRING,
TopicId STRING,
QuestionId STRING,
LocationId STRING,
BreakOutId STRING,
BreakOutCategoryid STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ","
, "quoteChar" = '"'
, "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/src/quality_of_life'
TBLPROPERTIES ("skip.header.line.count"="1");

-- load median earnings source data
DROP TABLE IF EXISTS src.median_earnings
CREATE EXTERNAL TABLE IF NOT EXISTS src.median_earnings (
GEO_id1 STRING,
GEO_id2 STRING,
GEO_display_label STRING,
HC01_EST_VC01 STRING,
HC01_MOE_VC01 STRING,
HC02_EST_VC01 STRING,
HC02_MOE_VC01 STRING,
HC03_EST_VC01 STRING,
HC03_MOE_VC01 STRING,
HC04_EST_VC01 STRING,
HC04_MOE_VC01 STRING,
HC05_EST_VC01 STRING,
HC05_MOE_VC01 STRING,
HC06_EST_VC01 STRING,
HC06_MOE_VC01 STRING,
HC01_EST_VC02 STRING,
HC01_MOE_VC02 STRING,
HC02_EST_VC02 STRING,
HC02_MOE_VC02 STRING,
HC03_EST_VC02 STRING,
HC03_MOE_VC02 STRING,
HC04_EST_VC02 STRING,
HC04_MOE_VC02 STRING,
HC05_EST_VC02 STRING,
HC05_MOE_VC02 STRING,
HC06_EST_VC02 STRING,
HC06_MOE_VC02 STRING,
HC01_EST_VC03 STRING,
HC01_MOE_VC03 STRING,
HC02_EST_VC03 STRING,
HC02_MOE_VC03 STRING,
HC03_EST_VC03 STRING,
HC03_MOE_VC03 STRING,
HC04_EST_VC03 STRING,
HC04_MOE_VC03 STRING,
HC05_EST_VC03 STRING,
HC05_MOE_VC03 STRING,
HC06_EST_VC03 STRING,
HC06_MOE_VC03 STRING,
HC01_EST_VC04 STRING,
HC01_MOE_VC04 STRING,
HC02_EST_VC04 STRING,
HC02_MOE_VC04 STRING,
HC03_EST_VC04 STRING,
HC03_MOE_VC04 STRING,
HC04_EST_VC04 STRING,
HC04_MOE_VC04 STRING,
HC05_EST_VC04 STRING,
HC05_MOE_VC04 STRING,
HC06_EST_VC04 STRING,
HC06_MOE_VC04 STRING,
HC01_EST_VC05 STRING,
HC01_MOE_VC05 STRING,
HC02_EST_VC05 STRING,
HC02_MOE_VC05 STRING,
HC03_EST_VC05 STRING,
HC03_MOE_VC05 STRING,
HC04_EST_VC05 STRING,
HC04_MOE_VC05 STRING,
HC05_EST_VC05 STRING,
HC05_MOE_VC05 STRING,
HC06_EST_VC05 STRING,
HC06_MOE_VC05 STRING,
HC01_EST_VC06 STRING,
HC01_MOE_VC06 STRING,
HC02_EST_VC06 STRING,
HC02_MOE_VC06 STRING,
HC03_EST_VC06 STRING,
HC03_MOE_VC06 STRING,
HC04_EST_VC06 STRING,
HC04_MOE_VC06 STRING,
HC05_EST_VC06 STRING,
HC05_MOE_VC06 STRING,
HC06_EST_VC06 STRING,
HC06_MOE_VC06 STRING,
HC01_EST_VC07 STRING,
HC01_MOE_VC07 STRING,
HC02_EST_VC07 STRING,
HC02_MOE_VC07 STRING,
HC03_EST_VC07 STRING,
HC03_MOE_VC07 STRING,
HC04_EST_VC07 STRING,
HC04_MOE_VC07 STRING,
HC05_EST_VC07 STRING,
HC05_MOE_VC07 STRING,
HC06_EST_VC07 STRING,
HC06_MOE_VC07 STRING,
HC01_EST_VC08 STRING,
HC01_MOE_VC08 STRING,
HC02_EST_VC08 STRING,
HC02_MOE_VC08 STRING,
HC03_EST_VC08 STRING,
HC03_MOE_VC08 STRING,
HC04_EST_VC08 STRING,
HC04_MOE_VC08 STRING,
HC05_EST_VC08 STRING,
HC05_MOE_VC08 STRING,
HC06_EST_VC08 STRING,
HC06_MOE_VC08 STRING,
HC01_EST_VC09 STRING,
HC01_MOE_VC09 STRING,
HC02_EST_VC09 STRING,
HC02_MOE_VC09 STRING,
HC03_EST_VC09 STRING,
HC03_MOE_VC09 STRING,
HC04_EST_VC09 STRING,
HC04_MOE_VC09 STRING,
HC05_EST_VC09 STRING,
HC05_MOE_VC09 STRING,
HC06_EST_VC09 STRING,
HC06_MOE_VC09 STRING,
HC01_EST_VC10 STRING,
HC01_MOE_VC10 STRING,
HC02_EST_VC10 STRING,
HC02_MOE_VC10 STRING,
HC03_EST_VC10 STRING,
HC03_MOE_VC10 STRING,
HC04_EST_VC10 STRING,
HC04_MOE_VC10 STRING,
HC05_EST_VC10 STRING,
HC05_MOE_VC10 STRING,
HC06_EST_VC10 STRING,
HC06_MOE_VC10 STRING,
HC01_EST_VC11 STRING,
HC01_MOE_VC11 STRING,
HC02_EST_VC11 STRING,
HC02_MOE_VC11 STRING,
HC03_EST_VC11 STRING,
HC03_MOE_VC11 STRING,
HC04_EST_VC11 STRING,
HC04_MOE_VC11 STRING,
HC05_EST_VC11 STRING,
HC05_MOE_VC11 STRING,
HC06_EST_VC11 STRING,
HC06_MOE_VC11 STRING,
HC01_EST_VC12 STRING,
HC01_MOE_VC12 STRING,
HC02_EST_VC12 STRING,
HC02_MOE_VC12 STRING,
HC03_EST_VC12 STRING,
HC03_MOE_VC12 STRING,
HC04_EST_VC12 STRING,
HC04_MOE_VC12 STRING,
HC05_EST_VC12 STRING,
HC05_MOE_VC12 STRING,
HC06_EST_VC12 STRING,
HC06_MOE_VC12 STRING,
HC01_EST_VC13 STRING,
HC01_MOE_VC13 STRING,
HC02_EST_VC13 STRING,
HC02_MOE_VC13 STRING,
HC03_EST_VC13 STRING,
HC03_MOE_VC13 STRING,
HC04_EST_VC13 STRING,
HC04_MOE_VC13 STRING,
HC05_EST_VC13 STRING,
HC05_MOE_VC13 STRING,
HC06_EST_VC13 STRING,
HC06_MOE_VC13 STRING,
HC01_EST_VC14 STRING,
HC01_MOE_VC14 STRING,
HC02_EST_VC14 STRING,
HC02_MOE_VC14 STRING,
HC03_EST_VC14 STRING,
HC03_MOE_VC14 STRING,
HC04_EST_VC14 STRING,
HC04_MOE_VC14 STRING,
HC05_EST_VC14 STRING,
HC05_MOE_VC14 STRING,
HC06_EST_VC14 STRING,
HC06_MOE_VC14 STRING,
HC01_EST_VC15 STRING,
HC01_MOE_VC15 STRING,
HC02_EST_VC15 STRING,
HC02_MOE_VC15 STRING,
HC03_EST_VC15 STRING,
HC03_MOE_VC15 STRING,
HC04_EST_VC15 STRING,
HC04_MOE_VC15 STRING,
HC05_EST_VC15 STRING,
HC05_MOE_VC15 STRING,
HC06_EST_VC15 STRING,
HC06_MOE_VC15 STRING,
HC01_EST_VC16 STRING,
HC01_MOE_VC16 STRING,
HC02_EST_VC16 STRING,
HC02_MOE_VC16 STRING,
HC03_EST_VC16 STRING,
HC03_MOE_VC16 STRING,
HC04_EST_VC16 STRING,
HC04_MOE_VC16 STRING,
HC05_EST_VC16 STRING,
HC05_MOE_VC16 STRING,
HC06_EST_VC16 STRING,
HC06_MOE_VC16 STRING,
HC01_EST_VC17 STRING,
HC01_MOE_VC17 STRING,
HC02_EST_VC17 STRING,
HC02_MOE_VC17 STRING,
HC03_EST_VC17 STRING,
HC03_MOE_VC17 STRING,
HC04_EST_VC17 STRING,
HC04_MOE_VC17 STRING,
HC05_EST_VC17 STRING,
HC05_MOE_VC17 STRING,
HC06_EST_VC17 STRING,
HC06_MOE_VC17 STRING,
HC01_EST_VC18 STRING,
HC01_MOE_VC18 STRING,
HC02_EST_VC18 STRING,
HC02_MOE_VC18 STRING,
HC03_EST_VC18 STRING,
HC03_MOE_VC18 STRING,
HC04_EST_VC18 STRING,
HC04_MOE_VC18 STRING,
HC05_EST_VC18 STRING,
HC05_MOE_VC18 STRING,
HC06_EST_VC18 STRING,
HC06_MOE_VC18 STRING,
HC01_EST_VC19 STRING,
HC01_MOE_VC19 STRING,
HC02_EST_VC19 STRING,
HC02_MOE_VC19 STRING,
HC03_EST_VC19 STRING,
HC03_MOE_VC19 STRING,
HC04_EST_VC19 STRING,
HC04_MOE_VC19 STRING,
HC05_EST_VC19 STRING,
HC05_MOE_VC19 STRING,
HC06_EST_VC19 STRING,
HC06_MOE_VC19 STRING,
HC01_EST_VC20 STRING,
HC01_MOE_VC20 STRING,
HC02_EST_VC20 STRING,
HC02_MOE_VC20 STRING,
HC03_EST_VC20 STRING,
HC03_MOE_VC20 STRING,
HC04_EST_VC20 STRING,
HC04_MOE_VC20 STRING,
HC05_EST_VC20 STRING,
HC05_MOE_VC20 STRING,
HC06_EST_VC20 STRING,
HC06_MOE_VC20 STRING,
HC01_EST_VC21 STRING,
HC01_MOE_VC21 STRING,
HC02_EST_VC21 STRING,
HC02_MOE_VC21 STRING,
HC03_EST_VC21 STRING,
HC03_MOE_VC21 STRING,
HC04_EST_VC21 STRING,
HC04_MOE_VC21 STRING,
HC05_EST_VC21 STRING,
HC05_MOE_VC21 STRING,
HC06_EST_VC21 STRING,
HC06_MOE_VC21 STRING,
HC01_EST_VC22 STRING,
HC01_MOE_VC22 STRING,
HC02_EST_VC22 STRING,
HC02_MOE_VC22 STRING,
HC03_EST_VC22 STRING,
HC03_MOE_VC22 STRING,
HC04_EST_VC22 STRING,
HC04_MOE_VC22 STRING,
HC05_EST_VC22 STRING,
HC05_MOE_VC22 STRING,
HC06_EST_VC22 STRING,
HC06_MOE_VC22 STRING,
HC01_EST_VC23 STRING,
HC01_MOE_VC23 STRING,
HC02_EST_VC23 STRING,
HC02_MOE_VC23 STRING,
HC03_EST_VC23 STRING,
HC03_MOE_VC23 STRING,
HC04_EST_VC23 STRING,
HC04_MOE_VC23 STRING,
HC05_EST_VC23 STRING,
HC05_MOE_VC23 STRING,
HC06_EST_VC23 STRING,
HC06_MOE_VC23 STRING,
HC01_EST_VC24 STRING,
HC01_MOE_VC24 STRING,
HC02_EST_VC24 STRING,
HC02_MOE_VC24 STRING,
HC03_EST_VC24 STRING,
HC03_MOE_VC24 STRING,
HC04_EST_VC24 STRING,
HC04_MOE_VC24 STRING,
HC05_EST_VC24 STRING,
HC05_MOE_VC24 STRING,
HC06_EST_VC24 STRING,
HC06_MOE_VC24 STRING,
HC01_EST_VC25 STRING,
HC01_MOE_VC25 STRING,
HC02_EST_VC25 STRING,
HC02_MOE_VC25 STRING,
HC03_EST_VC25 STRING,
HC03_MOE_VC25 STRING,
HC04_EST_VC25 STRING,
HC04_MOE_VC25 STRING,
HC05_EST_VC25 STRING,
HC05_MOE_VC25 STRING,
HC06_EST_VC25 STRING,
HC06_MOE_VC25 STRING,
HC01_EST_VC26 STRING,
HC01_MOE_VC26 STRING,
HC02_EST_VC26 STRING,
HC02_MOE_VC26 STRING,
HC03_EST_VC26 STRING,
HC03_MOE_VC26 STRING,
HC04_EST_VC26 STRING,
HC04_MOE_VC26 STRING,
HC05_EST_VC26 STRING,
HC05_MOE_VC26 STRING,
HC06_EST_VC26 STRING,
HC06_MOE_VC26 STRING,
HC01_EST_VC27 STRING,
HC01_MOE_VC27 STRING,
HC02_EST_VC27 STRING,
HC02_MOE_VC27 STRING,
HC03_EST_VC27 STRING,
HC03_MOE_VC27 STRING,
HC04_EST_VC27 STRING,
HC04_MOE_VC27 STRING,
HC05_EST_VC27 STRING,
HC05_MOE_VC27 STRING,
HC06_EST_VC27 STRING,
HC06_MOE_VC27 STRING,
HC01_EST_VC28 STRING,
HC01_MOE_VC28 STRING,
HC02_EST_VC28 STRING,
HC02_MOE_VC28 STRING,
HC03_EST_VC28 STRING,
HC03_MOE_VC28 STRING,
HC04_EST_VC28 STRING,
HC04_MOE_VC28 STRING,
HC05_EST_VC28 STRING,
HC05_MOE_VC28 STRING,
HC06_EST_VC28 STRING,
HC06_MOE_VC28 STRING,
HC01_EST_VC29 STRING,
HC01_MOE_VC29 STRING,
HC02_EST_VC29 STRING,
HC02_MOE_VC29 STRING,
HC03_EST_VC29 STRING,
HC03_MOE_VC29 STRING,
HC04_EST_VC29 STRING,
HC04_MOE_VC29 STRING,
HC05_EST_VC29 STRING,
HC05_MOE_VC29 STRING,
HC06_EST_VC29 STRING,
HC06_MOE_VC29 STRING,
HC01_EST_VC30 STRING,
HC01_MOE_VC30 STRING,
HC02_EST_VC30 STRING,
HC02_MOE_VC30 STRING,
HC03_EST_VC30 STRING,
HC03_MOE_VC30 STRING,
HC04_EST_VC30 STRING,
HC04_MOE_VC30 STRING,
HC05_EST_VC30 STRING,
HC05_MOE_VC30 STRING,
HC06_EST_VC30 STRING,
HC06_MOE_VC30 STRING,
HC01_EST_VC31 STRING,
HC01_MOE_VC31 STRING,
HC02_EST_VC31 STRING,
HC02_MOE_VC31 STRING,
HC03_EST_VC31 STRING,
HC03_MOE_VC31 STRING,
HC04_EST_VC31 STRING,
HC04_MOE_VC31 STRING,
HC05_EST_VC31 STRING,
HC05_MOE_VC31 STRING,
HC06_EST_VC31 STRING,
HC06_MOE_VC31 STRING,
HC01_EST_VC32 STRING,
HC01_MOE_VC32 STRING,
HC02_EST_VC32 STRING,
HC02_MOE_VC32 STRING,
HC03_EST_VC32 STRING,
HC03_MOE_VC32 STRING,
HC04_EST_VC32 STRING,
HC04_MOE_VC32 STRING,
HC05_EST_VC32 STRING,
HC05_MOE_VC32 STRING,
HC06_EST_VC32 STRING,
HC06_MOE_VC32 STRING,
HC01_EST_VC33 STRING,
HC01_MOE_VC33 STRING,
HC02_EST_VC33 STRING,
HC02_MOE_VC33 STRING,
HC03_EST_VC33 STRING,
HC03_MOE_VC33 STRING,
HC04_EST_VC33 STRING,
HC04_MOE_VC33 STRING,
HC05_EST_VC33 STRING,
HC05_MOE_VC33 STRING,
HC06_EST_VC33 STRING,
HC06_MOE_VC33 STRING,
HC01_EST_VC34 STRING,
HC01_MOE_VC34 STRING,
HC02_EST_VC34 STRING,
HC02_MOE_VC34 STRING,
HC03_EST_VC34 STRING,
HC03_MOE_VC34 STRING,
HC04_EST_VC34 STRING,
HC04_MOE_VC34 STRING,
HC05_EST_VC34 STRING,
HC05_MOE_VC34 STRING,
HC06_EST_VC34 STRING,
HC06_MOE_VC34 STRING,
HC01_EST_VC35 STRING,
HC01_MOE_VC35 STRING,
HC02_EST_VC35 STRING,
HC02_MOE_VC35 STRING,
HC03_EST_VC35 STRING,
HC03_MOE_VC35 STRING,
HC04_EST_VC35 STRING,
HC04_MOE_VC35 STRING,
HC05_EST_VC35 STRING,
HC05_MOE_VC35 STRING,
HC06_EST_VC35 STRING,
HC06_MOE_VC35 STRING,
HC01_EST_VC36 STRING,
HC01_MOE_VC36 STRING,
HC02_EST_VC36 STRING,
HC02_MOE_VC36 STRING,
HC03_EST_VC36 STRING,
HC03_MOE_VC36 STRING,
HC04_EST_VC36 STRING,
HC04_MOE_VC36 STRING,
HC05_EST_VC36 STRING,
HC05_MOE_VC36 STRING,
HC06_EST_VC36 STRING,
HC06_MOE_VC36 STRING,
HC01_EST_VC39 STRING,
HC01_MOE_VC39 STRING,
HC02_EST_VC39 STRING,
HC02_MOE_VC39 STRING,
HC03_EST_VC39 STRING,
HC03_MOE_VC39 STRING,
HC04_EST_VC39 STRING,
HC04_MOE_VC39 STRING,
HC05_EST_VC39 STRING,
HC05_MOE_VC39 STRING,
HC06_EST_VC39 STRING,
HC06_MOE_VC39 STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ","
, "quoteChar" = '"'
, "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/src/median_earnings'
TBLPROPERTIES ("skip.header.line.count"="1");