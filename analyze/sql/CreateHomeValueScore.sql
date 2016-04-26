drop table if exists wrk.home_score;
CREATE TABLE wrk.home_score (
	home_score_id INT,
	batch_id INT NULL,
	city_id INT NULL,
	median_home_value FLOAT null
	);
	
insert into wrk.home_score(home_score_id, batch_id, city_id, median_home_value)
select
	cast(median_home_value_id as int) as home_score_id,
	cast(src.median_home_value.batch_id as int) as batch_id,
	cast(city_code as INT) as city_id,
	cast(median_value as float) as median_home_value
from src.median_home_value
inner join src.batch
	on src.batch.batch_id = src.median_home_value.batch_id
	where src.batch.is_active = true;
