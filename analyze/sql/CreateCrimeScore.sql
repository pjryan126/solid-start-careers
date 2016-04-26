DROP TABLE IF EXISTS wrk.crime_stats_latestBatch;
CREATE TABLE wrk.crime_stats_latestBatch (
state TEXT
, year INT
, property_crime_rate FLOAT
, burglary_rate FLOAT
, larceny_theft_rate FLOAT
, auto_theft_rate FLOAT
);
INSERT INTO wrk.crime_stats_latestBatch (state, year, property_crime_rate, burglary_rate, larceny_theft_rate, auto_theft_rate) 
SELECT
state
, CAST(year AS INT)
, CAST(property_crime_rate AS FLOAT)
, CAST(burglary_rate AS FLOAT)
, CAST(larceny_theft_rate AS FLOAT)
, CAST(auto_theft_rate AS FLOAT)
FROM src.crime_stats
inner join src.batch
	on src.batch.batch_id = src.crime_stats.batch_id
	where src.batch.is_active = true;
	
drop table if exists wrk.crime_score;
CREATE TABLE wrk.crime_score (
state_name TEXT
, score FLOAT
);
INSERT INTO wrk.crime_score (state_name, score) 
SELECT
state as state_name
, AVG(property_crime_rate + burglary_rate + larceny_theft_rate + auto_theft_rate)
FROM wrk.crime_stats_latestBatch
group by state;
drop table wrk.crime_stats_latestBatch;