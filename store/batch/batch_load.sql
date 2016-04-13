-- create crime stats source table
DROP TABLE IF EXISTS src.crime_stats;
CREATE TABLE src.crime_stats (
year TEXT,
population TEXT,
violent_crime_rate TEXT,
homicide_rate TEXT,
rape_rate TEXT,
robbery_rate TEXT,
aggr_assault_rate TEXT,
property_crime_rate TEXT,
burglary_rate TEXT,
larceny_theft_rate TEXT,
auto_theft_rate TEXT
);



-- create park score source table
DROP TABLE IF EXISTS src.park_score;
CREATE TABLE src.park_score (
city TEXT, 
state TEXT,
year TEXT,
score TEXT
);

--create quality of life source table
DROP TABLE IF EXISTS src.quality_of_life;
CREATE TABLE src.quality_of_life (
Year TEXT,
LocationAbbr TEXT,
LocationDesc TEXT,
Category TEXT,
Topic TEXT,
Question TEXT,
DataSource TEXT,
Data_Value_Unit TEXT,
Data_Value_Type TEXT,
Data_Value TEXT,
Data_Value_Footnote_Symbol TEXT,
Data_Value_Footnote TEXT,
Data_Value_Std_Err TEXT,
Low_Confidence_Limit TEXT,
High_Confidence_Limit TEXT,
Sample_Size TEXT,
Break_Out TEXT,
Break_Out_Category TEXT,
GeoLocation TEXT,
CategoryId TEXT,
TopicId TEXT,
QuestionId TEXT,
LocationId TEXT,
BreakOutId TEXT,
BreakOutCategoryid
);



-- load median earnings source data
DROP TABLE IF EXISTS src.median_earnings
CREATE TABLE src.median_earnings (
GEO_id1 TEXT,
GEO_id2 TEXT,
GEO_display_label TEXT,
HC01_EST_VC01 TEXT,
HC01_MOE_VC01 TEXT,
HC02_EST_VC01 TEXT,
HC02_MOE_VC01 TEXT,
HC03_EST_VC01 TEXT,
HC03_MOE_VC01 TEXT,
HC04_EST_VC01 TEXT,
HC04_MOE_VC01 TEXT,
HC05_EST_VC01 TEXT,
HC05_MOE_VC01 TEXT,
HC06_EST_VC01 TEXT,
HC06_MOE_VC01 TEXT,
HC01_EST_VC02 TEXT,
HC01_MOE_VC02 TEXT,
HC02_EST_VC02 TEXT,
HC02_MOE_VC02 TEXT,
HC03_EST_VC02 TEXT,
HC03_MOE_VC02 TEXT,
HC04_EST_VC02 TEXT,
HC04_MOE_VC02 TEXT,
HC05_EST_VC02 TEXT,
HC05_MOE_VC02 TEXT,
HC06_EST_VC02 TEXT,
HC06_MOE_VC02 TEXT,
HC01_EST_VC03 TEXT,
HC01_MOE_VC03 TEXT,
HC02_EST_VC03 TEXT,
HC02_MOE_VC03 TEXT,
HC03_EST_VC03 TEXT,
HC03_MOE_VC03 TEXT,
HC04_EST_VC03 TEXT,
HC04_MOE_VC03 TEXT,
HC05_EST_VC03 TEXT,
HC05_MOE_VC03 TEXT,
HC06_EST_VC03 TEXT,
HC06_MOE_VC03 TEXT,
HC01_EST_VC04 TEXT,
HC01_MOE_VC04 TEXT,
HC02_EST_VC04 TEXT,
HC02_MOE_VC04 TEXT,
HC03_EST_VC04 TEXT,
HC03_MOE_VC04 TEXT,
HC04_EST_VC04 TEXT,
HC04_MOE_VC04 TEXT,
HC05_EST_VC04 TEXT,
HC05_MOE_VC04 TEXT,
HC06_EST_VC04 TEXT,
HC06_MOE_VC04 TEXT,
HC01_EST_VC05 TEXT,
HC01_MOE_VC05 TEXT,
HC02_EST_VC05 TEXT,
HC02_MOE_VC05 TEXT,
HC03_EST_VC05 TEXT,
HC03_MOE_VC05 TEXT,
HC04_EST_VC05 TEXT,
HC04_MOE_VC05 TEXT,
HC05_EST_VC05 TEXT,
HC05_MOE_VC05 TEXT,
HC06_EST_VC05 TEXT,
HC06_MOE_VC05 TEXT,
HC01_EST_VC06 TEXT,
HC01_MOE_VC06 TEXT,
HC02_EST_VC06 TEXT,
HC02_MOE_VC06 TEXT,
HC03_EST_VC06 TEXT,
HC03_MOE_VC06 TEXT,
HC04_EST_VC06 TEXT,
HC04_MOE_VC06 TEXT,
HC05_EST_VC06 TEXT,
HC05_MOE_VC06 TEXT,
HC06_EST_VC06 TEXT,
HC06_MOE_VC06 TEXT,
HC01_EST_VC07 TEXT,
HC01_MOE_VC07 TEXT,
HC02_EST_VC07 TEXT,
HC02_MOE_VC07 TEXT,
HC03_EST_VC07 TEXT,
HC03_MOE_VC07 TEXT,
HC04_EST_VC07 TEXT,
HC04_MOE_VC07 TEXT,
HC05_EST_VC07 TEXT,
HC05_MOE_VC07 TEXT,
HC06_EST_VC07 TEXT,
HC06_MOE_VC07 TEXT,
HC01_EST_VC08 TEXT,
HC01_MOE_VC08 TEXT,
HC02_EST_VC08 TEXT,
HC02_MOE_VC08 TEXT,
HC03_EST_VC08 TEXT,
HC03_MOE_VC08 TEXT,
HC04_EST_VC08 TEXT,
HC04_MOE_VC08 TEXT,
HC05_EST_VC08 TEXT,
HC05_MOE_VC08 TEXT,
HC06_EST_VC08 TEXT,
HC06_MOE_VC08 TEXT,
HC01_EST_VC09 TEXT,
HC01_MOE_VC09 TEXT,
HC02_EST_VC09 TEXT,
HC02_MOE_VC09 TEXT,
HC03_EST_VC09 TEXT,
HC03_MOE_VC09 TEXT,
HC04_EST_VC09 TEXT,
HC04_MOE_VC09 TEXT,
HC05_EST_VC09 TEXT,
HC05_MOE_VC09 TEXT,
HC06_EST_VC09 TEXT,
HC06_MOE_VC09 TEXT,
HC01_EST_VC10 TEXT,
HC01_MOE_VC10 TEXT,
HC02_EST_VC10 TEXT,
HC02_MOE_VC10 TEXT,
HC03_EST_VC10 TEXT,
HC03_MOE_VC10 TEXT,
HC04_EST_VC10 TEXT,
HC04_MOE_VC10 TEXT,
HC05_EST_VC10 TEXT,
HC05_MOE_VC10 TEXT,
HC06_EST_VC10 TEXT,
HC06_MOE_VC10 TEXT,
HC01_EST_VC11 TEXT,
HC01_MOE_VC11 TEXT,
HC02_EST_VC11 TEXT,
HC02_MOE_VC11 TEXT,
HC03_EST_VC11 TEXT,
HC03_MOE_VC11 TEXT,
HC04_EST_VC11 TEXT,
HC04_MOE_VC11 TEXT,
HC05_EST_VC11 TEXT,
HC05_MOE_VC11 TEXT,
HC06_EST_VC11 TEXT,
HC06_MOE_VC11 TEXT,
HC01_EST_VC12 TEXT,
HC01_MOE_VC12 TEXT,
HC02_EST_VC12 TEXT,
HC02_MOE_VC12 TEXT,
HC03_EST_VC12 TEXT,
HC03_MOE_VC12 TEXT,
HC04_EST_VC12 TEXT,
HC04_MOE_VC12 TEXT,
HC05_EST_VC12 TEXT,
HC05_MOE_VC12 TEXT,
HC06_EST_VC12 TEXT,
HC06_MOE_VC12 TEXT,
HC01_EST_VC13 TEXT,
HC01_MOE_VC13 TEXT,
HC02_EST_VC13 TEXT,
HC02_MOE_VC13 TEXT,
HC03_EST_VC13 TEXT,
HC03_MOE_VC13 TEXT,
HC04_EST_VC13 TEXT,
HC04_MOE_VC13 TEXT,
HC05_EST_VC13 TEXT,
HC05_MOE_VC13 TEXT,
HC06_EST_VC13 TEXT,
HC06_MOE_VC13 TEXT,
HC01_EST_VC14 TEXT,
HC01_MOE_VC14 TEXT,
HC02_EST_VC14 TEXT,
HC02_MOE_VC14 TEXT,
HC03_EST_VC14 TEXT,
HC03_MOE_VC14 TEXT,
HC04_EST_VC14 TEXT,
HC04_MOE_VC14 TEXT,
HC05_EST_VC14 TEXT,
HC05_MOE_VC14 TEXT,
HC06_EST_VC14 TEXT,
HC06_MOE_VC14 TEXT,
HC01_EST_VC15 TEXT,
HC01_MOE_VC15 TEXT,
HC02_EST_VC15 TEXT,
HC02_MOE_VC15 TEXT,
HC03_EST_VC15 TEXT,
HC03_MOE_VC15 TEXT,
HC04_EST_VC15 TEXT,
HC04_MOE_VC15 TEXT,
HC05_EST_VC15 TEXT,
HC05_MOE_VC15 TEXT,
HC06_EST_VC15 TEXT,
HC06_MOE_VC15 TEXT,
HC01_EST_VC16 TEXT,
HC01_MOE_VC16 TEXT,
HC02_EST_VC16 TEXT,
HC02_MOE_VC16 TEXT,
HC03_EST_VC16 TEXT,
HC03_MOE_VC16 TEXT,
HC04_EST_VC16 TEXT,
HC04_MOE_VC16 TEXT,
HC05_EST_VC16 TEXT,
HC05_MOE_VC16 TEXT,
HC06_EST_VC16 TEXT,
HC06_MOE_VC16 TEXT,
HC01_EST_VC17 TEXT,
HC01_MOE_VC17 TEXT,
HC02_EST_VC17 TEXT,
HC02_MOE_VC17 TEXT,
HC03_EST_VC17 TEXT,
HC03_MOE_VC17 TEXT,
HC04_EST_VC17 TEXT,
HC04_MOE_VC17 TEXT,
HC05_EST_VC17 TEXT,
HC05_MOE_VC17 TEXT,
HC06_EST_VC17 TEXT,
HC06_MOE_VC17 TEXT,
HC01_EST_VC18 TEXT,
HC01_MOE_VC18 TEXT,
HC02_EST_VC18 TEXT,
HC02_MOE_VC18 TEXT,
HC03_EST_VC18 TEXT,
HC03_MOE_VC18 TEXT,
HC04_EST_VC18 TEXT,
HC04_MOE_VC18 TEXT,
HC05_EST_VC18 TEXT,
HC05_MOE_VC18 TEXT,
HC06_EST_VC18 TEXT,
HC06_MOE_VC18 TEXT,
HC01_EST_VC19 TEXT,
HC01_MOE_VC19 TEXT,
HC02_EST_VC19 TEXT,
HC02_MOE_VC19 TEXT,
HC03_EST_VC19 TEXT,
HC03_MOE_VC19 TEXT,
HC04_EST_VC19 TEXT,
HC04_MOE_VC19 TEXT,
HC05_EST_VC19 TEXT,
HC05_MOE_VC19 TEXT,
HC06_EST_VC19 TEXT,
HC06_MOE_VC19 TEXT,
HC01_EST_VC20 TEXT,
HC01_MOE_VC20 TEXT,
HC02_EST_VC20 TEXT,
HC02_MOE_VC20 TEXT,
HC03_EST_VC20 TEXT,
HC03_MOE_VC20 TEXT,
HC04_EST_VC20 TEXT,
HC04_MOE_VC20 TEXT,
HC05_EST_VC20 TEXT,
HC05_MOE_VC20 TEXT,
HC06_EST_VC20 TEXT,
HC06_MOE_VC20 TEXT,
HC01_EST_VC21 TEXT,
HC01_MOE_VC21 TEXT,
HC02_EST_VC21 TEXT,
HC02_MOE_VC21 TEXT,
HC03_EST_VC21 TEXT,
HC03_MOE_VC21 TEXT,
HC04_EST_VC21 TEXT,
HC04_MOE_VC21 TEXT,
HC05_EST_VC21 TEXT,
HC05_MOE_VC21 TEXT,
HC06_EST_VC21 TEXT,
HC06_MOE_VC21 TEXT,
HC01_EST_VC22 TEXT,
HC01_MOE_VC22 TEXT,
HC02_EST_VC22 TEXT,
HC02_MOE_VC22 TEXT,
HC03_EST_VC22 TEXT,
HC03_MOE_VC22 TEXT,
HC04_EST_VC22 TEXT,
HC04_MOE_VC22 TEXT,
HC05_EST_VC22 TEXT,
HC05_MOE_VC22 TEXT,
HC06_EST_VC22 TEXT,
HC06_MOE_VC22 TEXT,
HC01_EST_VC23 TEXT,
HC01_MOE_VC23 TEXT,
HC02_EST_VC23 TEXT,
HC02_MOE_VC23 TEXT,
HC03_EST_VC23 TEXT,
HC03_MOE_VC23 TEXT,
HC04_EST_VC23 TEXT,
HC04_MOE_VC23 TEXT,
HC05_EST_VC23 TEXT,
HC05_MOE_VC23 TEXT,
HC06_EST_VC23 TEXT,
HC06_MOE_VC23 TEXT,
HC01_EST_VC24 TEXT,
HC01_MOE_VC24 TEXT,
HC02_EST_VC24 TEXT,
HC02_MOE_VC24 TEXT,
HC03_EST_VC24 TEXT,
HC03_MOE_VC24 TEXT,
HC04_EST_VC24 TEXT,
HC04_MOE_VC24 TEXT,
HC05_EST_VC24 TEXT,
HC05_MOE_VC24 TEXT,
HC06_EST_VC24 TEXT,
HC06_MOE_VC24 TEXT,
HC01_EST_VC25 TEXT,
HC01_MOE_VC25 TEXT,
HC02_EST_VC25 TEXT,
HC02_MOE_VC25 TEXT,
HC03_EST_VC25 TEXT,
HC03_MOE_VC25 TEXT,
HC04_EST_VC25 TEXT,
HC04_MOE_VC25 TEXT,
HC05_EST_VC25 TEXT,
HC05_MOE_VC25 TEXT,
HC06_EST_VC25 TEXT,
HC06_MOE_VC25 TEXT,
HC01_EST_VC26 TEXT,
HC01_MOE_VC26 TEXT,
HC02_EST_VC26 TEXT,
HC02_MOE_VC26 TEXT,
HC03_EST_VC26 TEXT,
HC03_MOE_VC26 TEXT,
HC04_EST_VC26 TEXT,
HC04_MOE_VC26 TEXT,
HC05_EST_VC26 TEXT,
HC05_MOE_VC26 TEXT,
HC06_EST_VC26 TEXT,
HC06_MOE_VC26 TEXT,
HC01_EST_VC27 TEXT,
HC01_MOE_VC27 TEXT,
HC02_EST_VC27 TEXT,
HC02_MOE_VC27 TEXT,
HC03_EST_VC27 TEXT,
HC03_MOE_VC27 TEXT,
HC04_EST_VC27 TEXT,
HC04_MOE_VC27 TEXT,
HC05_EST_VC27 TEXT,
HC05_MOE_VC27 TEXT,
HC06_EST_VC27 TEXT,
HC06_MOE_VC27 TEXT,
HC01_EST_VC28 TEXT,
HC01_MOE_VC28 TEXT,
HC02_EST_VC28 TEXT,
HC02_MOE_VC28 TEXT,
HC03_EST_VC28 TEXT,
HC03_MOE_VC28 TEXT,
HC04_EST_VC28 TEXT,
HC04_MOE_VC28 TEXT,
HC05_EST_VC28 TEXT,
HC05_MOE_VC28 TEXT,
HC06_EST_VC28 TEXT,
HC06_MOE_VC28 TEXT,
HC01_EST_VC29 TEXT,
HC01_MOE_VC29 TEXT,
HC02_EST_VC29 TEXT,
HC02_MOE_VC29 TEXT,
HC03_EST_VC29 TEXT,
HC03_MOE_VC29 TEXT,
HC04_EST_VC29 TEXT,
HC04_MOE_VC29 TEXT,
HC05_EST_VC29 TEXT,
HC05_MOE_VC29 TEXT,
HC06_EST_VC29 TEXT,
HC06_MOE_VC29 TEXT,
HC01_EST_VC30 TEXT,
HC01_MOE_VC30 TEXT,
HC02_EST_VC30 TEXT,
HC02_MOE_VC30 TEXT,
HC03_EST_VC30 TEXT,
HC03_MOE_VC30 TEXT,
HC04_EST_VC30 TEXT,
HC04_MOE_VC30 TEXT,
HC05_EST_VC30 TEXT,
HC05_MOE_VC30 TEXT,
HC06_EST_VC30 TEXT,
HC06_MOE_VC30 TEXT,
HC01_EST_VC31 TEXT,
HC01_MOE_VC31 TEXT,
HC02_EST_VC31 TEXT,
HC02_MOE_VC31 TEXT,
HC03_EST_VC31 TEXT,
HC03_MOE_VC31 TEXT,
HC04_EST_VC31 TEXT,
HC04_MOE_VC31 TEXT,
HC05_EST_VC31 TEXT,
HC05_MOE_VC31 TEXT,
HC06_EST_VC31 TEXT,
HC06_MOE_VC31 TEXT,
HC01_EST_VC32 TEXT,
HC01_MOE_VC32 TEXT,
HC02_EST_VC32 TEXT,
HC02_MOE_VC32 TEXT,
HC03_EST_VC32 TEXT,
HC03_MOE_VC32 TEXT,
HC04_EST_VC32 TEXT,
HC04_MOE_VC32 TEXT,
HC05_EST_VC32 TEXT,
HC05_MOE_VC32 TEXT,
HC06_EST_VC32 TEXT,
HC06_MOE_VC32 TEXT,
HC01_EST_VC33 TEXT,
HC01_MOE_VC33 TEXT,
HC02_EST_VC33 TEXT,
HC02_MOE_VC33 TEXT,
HC03_EST_VC33 TEXT,
HC03_MOE_VC33 TEXT,
HC04_EST_VC33 TEXT,
HC04_MOE_VC33 TEXT,
HC05_EST_VC33 TEXT,
HC05_MOE_VC33 TEXT,
HC06_EST_VC33 TEXT,
HC06_MOE_VC33 TEXT,
HC01_EST_VC34 TEXT,
HC01_MOE_VC34 TEXT,
HC02_EST_VC34 TEXT,
HC02_MOE_VC34 TEXT,
HC03_EST_VC34 TEXT,
HC03_MOE_VC34 TEXT,
HC04_EST_VC34 TEXT,
HC04_MOE_VC34 TEXT,
HC05_EST_VC34 TEXT,
HC05_MOE_VC34 TEXT,
HC06_EST_VC34 TEXT,
HC06_MOE_VC34 TEXT,
HC01_EST_VC35 TEXT,
HC01_MOE_VC35 TEXT,
HC02_EST_VC35 TEXT,
HC02_MOE_VC35 TEXT,
HC03_EST_VC35 TEXT,
HC03_MOE_VC35 TEXT,
HC04_EST_VC35 TEXT,
HC04_MOE_VC35 TEXT,
HC05_EST_VC35 TEXT,
HC05_MOE_VC35 TEXT,
HC06_EST_VC35 TEXT,
HC06_MOE_VC35 TEXT,
HC01_EST_VC36 TEXT,
HC01_MOE_VC36 TEXT,
HC02_EST_VC36 TEXT,
HC02_MOE_VC36 TEXT,
HC03_EST_VC36 TEXT,
HC03_MOE_VC36 TEXT,
HC04_EST_VC36 TEXT,
HC04_MOE_VC36 TEXT,
HC05_EST_VC36 TEXT,
HC05_MOE_VC36 TEXT,
HC06_EST_VC36 TEXT,
HC06_MOE_VC36 TEXT,
HC01_EST_VC39 TEXT,
HC01_MOE_VC39 TEXT,
HC02_EST_VC39 TEXT,
HC02_MOE_VC39 TEXT,
HC03_EST_VC39 TEXT,
HC03_MOE_VC39 TEXT,
HC04_EST_VC39 TEXT,
HC04_MOE_VC39 TEXT,
HC05_EST_VC39 TEXT,
HC05_MOE_VC39 TEXT,
HC06_EST_VC39 TEXT,
HC06_MOE_VC39 TEXT
)

-- load crime stats source data
\copy src.crime_stats FROM '/data/batch/crime_stats.csv' WITH DELIMITER AS ',' CSV HEADER QUOTE AS '"'
-- load park score source data
\copy src.park_score FROM '/data/batch/park_score.csv' WITH DELIMITER AS ',' CSV HEADER QUOTE AS '"'
-- load quality of life source data
\copy src.quality_of_life FROM '/data/batch/quality_of_life.csv' WITH DELIMITER AS ',' CSV HEADER QUOTE AS '"';
-- load median earnings source data
\copy src.median_earnings FROM '/data/batch/median_earnings.csv' WITH DELIMITER AS ',' CSV HEADER QUOTE AS '"'

