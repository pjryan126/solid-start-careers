DROP TABLE IF exists wrk.jobs_temp;
CREATE TABLE wrk.jobs_temp (
	batch_id INT NULL,
	category_id INT NULL,
	numJobs INT NULL,
	cityState TEXT NULL,
	state_code TEXT NULL,
	state_name TEXT NULL,
	lat float NULL,
	long float NULL
);
INSERT INTO wrk.jobs_temp (batch_id, category_id, numJobs, cityState, state_code, state_name, lat, long) 
select
CAST(src.jobs_data.batch_id AS INT)
, CAST(category_id AS INT)
, CAST("numJobs" AS INT) as numJobs
, CAST(src.jobs_data."name" AS TEXT) as cityState
, CAST("stateAbbreviation" AS TEXT) as state_code
, CAST("stateName" AS TEXT) as state_name
, CAST(latitude AS FLOAT) as lat
, CAST(longitude AS FLOAT) as long
FROM src.jobs_data
inner join src.batch
   on src.batch.batch_id = src.jobs_data.batch_id
   where src.batch.is_active = true;
   

DROP TABLE IF exists wrk.jobs;
CREATE TABLE wrk.jobs (
	batch_id INT NULL,
	category_id INT NULL,
	numJobs INT NULL,
	city TEXT NULL,
	state_code TEXT NULL,
	state_name TEXT NULL,
	lat float NULL,
	long float NULL
);
INSERT INTO wrk.jobs (batch_id, category_id, numJobs, city, state_code, state_name, lat, long) 
select
batch_id
, category_id
, numJobs
, SUBSTRING(cityState, 1, CASE position(',' in cityState) WHEN 0 THEN char_length(cityState) ELSE position(',' in cityState)-1 END) AS city
, state_code
, state_name
, lat
, long
FROM wrk.jobs_temp;
drop table wrk.jobs_temp;