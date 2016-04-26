DELETE FROM src.median_earnings
WHERE hc04_est_vc01 like '%+%' or hc04_est_vc01 like '%-%' or geo_id1 = 'Id';
 
drop table if exists wrk.temp_earnings;
CREATE TABLE wrk.temp_earnings (
	geoId INT NULL,
	cityState varchar,
	median_earnings float NULL
);
insert into wrk.temp_earnings(geoId, cityState, median_earnings) 
select
cast(geo_id2 as INT) as geoId
, cast(geo_display_label as TEXT) as cityState
, CAST(hc04_est_vc01 as float) as median_earnings
from src.median_earnings
inner join src.batch
	on src.batch.batch_id = src.median_earnings.batch_id
	where src.batch.is_active = true;

DROP TABLE IF EXISTS wrk.earnings;
CREATE TABLE wrk.earnings (
geoId INT
, city TEXT
, state_name TEXT
, median_earnings FLOAT
);
INSERT INTO wrk.earnings(geoId, city, state_name, median_earnings) 
SELECT
geoId
, SUBSTRING(cityState, 1, CASE position(',' in cityState) WHEN 0 THEN char_length(cityState) ELSE position(',' in cityState)-1 END) AS city
, SUBSTRING(cityState, CASE position(',' in cityState) WHEN 0 THEN char_length(cityState)+1 ELSE position(',' in cityState)+1 END, 1000) AS state_name
, median_earnings
FROM  wrk.temp_earnings;
