drop table if exists wrk.park_score;
create table wrk.park_score(
	park_score_id int
	, batch_id int
	, city text
	, state_name text
	, state_code text
	, score float
);

insert into wrk.park_score(
park_score_id
	, batch_id
	, city
	, state_name
	, state_code
	, score)
select 
	src.park_score.park_score_id
	, src.park_score.batch_id
	, src.park_score.city
	, wrk.statelookup.state_name as state_name
	, src.park_score."state" as state_code
	, cast(src.park_score.score as float) as score
from src.park_score
inner join wrk.statelookup
	on wrk.statelookup.state_code = src.park_score."state"
inner join src.batch
	on src.park_score.batch_id = src.batch.batch_id where src.batch.is_active = true;
	