drop table if exists wrk.statelookup;
CREATE TABLE wrk.statelookup
(
   state_name     VARCHAR (32),
   state_code   CHAR (2)
);
 
INSERT INTO wrk.statelookup
VALUES ('Alabama', 'AL'),
       ('Alaska', 'AK'),
       ('Arizona', 'AZ'),
       ('Arkansas', 'AR'),
       ('California', 'CA'),
       ('Colorado', 'CO'),
       ('Connecticut', 'CT'),
       ('Delaware', 'DE'),
       ('District of Columbia', 'DC'),
       ('Florida', 'FL'),
       ('Georgia', 'GA'),
       ('Hawaii', 'HI'),
       ('Idaho', 'ID'),
       ('Illinois', 'IL'),
       ('Indiana', 'IN'),
       ('Iowa', 'IA'),
       ('Kansas', 'KS'),
       ('Kentucky', 'KY'),
       ('Louisiana', 'LA'),
       ('Maine', 'ME'),
       ('Maryland', 'MD'),
       ('Massachusetts', 'MA'),
       ('Michigan', 'MI'),
       ('Minnesota', 'MN'),
       ('Mississippi', 'MS'),
       ('Missouri', 'MO'),
       ('Montana', 'MT'),
       ('Nebraska', 'NE'),
       ('Nevada', 'NV'),
       ('New Hampshire', 'NH'),
       ('New Jersey', 'NJ'),
       ('New Mexico', 'NM'),
       ('New York', 'NY'),
       ('North Carolina', 'NC'),
       ('North Dakota', 'ND'),
       ('Ohio', 'OH'),
       ('Oklahoma', 'OK'),
       ('Oregon', 'OR'),
       ('Pennsylvania', 'PA'),
       ('Rhode Island', 'RI'),
       ('South Carolina', 'SC'),
       ('South Dakota', 'SD'),
       ('Tennessee', 'TN'),
       ('Texas', 'TX'),
       ('Utah', 'UT'),
       ('Vermont', 'VT'),
       ('Virginia', 'VA'),
       ('Washington', 'WA'),
       ('West Virginia', 'WV'),
       ('Wisconsin', 'WI'),
       ('Wyoming', 'WY');

       
drop table if exists wrk.location_all;
create table wrk.location_all(
city TEXT
, state_name TEXT
, state_code TEXT
, county TEXT
, long FLOAT
, lat FLOAT
, zip_code TEXT
, location_id TEXT
, batch_id INT
);
INSERT into wrk.location_all(
city
, state_name
, state_code
, county
, long
, lat
, zip_code
, location_id
, batch_id
)  
SELECT
src.location.city
, wrk.statelookup.state_name
, wrk.statelookup.state_code
, src.location.county
, CAST(src.location.longitude as float) as long
, CAST(src.location.latitude as float) as lat
, src.location.zip_code
, src.location.location_id
, CAST(src.location.batch_id as INT) as batch_id
FROM src.location
INNER JOIN wrk.statelookup
  ON src.location.state = wrk.statelookup.state_code;
  
drop table if exists wrk.location_final;
create table wrk.location_final(
city TEXT
, state_name TEXT
, state_code TEXT
, county TEXT
, long FLOAT
, lat FLOAT
, zip_code TEXT
, batch_id INT
, city_id INT
);
INSERT into wrk.location_final(
city
, state_name
, state_code
, county
, long
, lat
, zip_code
, batch_id
, city_id
)
SELECT
wrk.location_all.city
, wrk.location_all.state_name
, wrk.location_all.state_code
, wrk.location_all.county
, wrk.location_all.long
, wrk.location_all.lat
, wrk.location_all.zip_code
, wrk.location_all.batch_id
, cast(src.city_data.city_id as int) as city_id
FROM wrk.location_all
INNER JOIN src.city_data
  ON src.city_data."state" = wrk.location_all.state_code and src.city_data.region = wrk.location_all.city
INNER JOIN src.batch
  ON src.batch.batch_id = wrk.location_all.batch_id where src.batch.is_active = true;
