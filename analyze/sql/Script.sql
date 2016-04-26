drop table if exists wrk.final_result;
CREATE TABLE wrk.final_result (
    city TEXT,
    state_name TEXT,
    state_code TEXT,
	crime_score float,
	park_score float,
	jobs_score float,
    home_score float
);


insert into wrk.final_result(city, state_name, state_code, crime_score, park_score, jobs_score, home_score)
select
	wrk.location_final.city,
	wrk.location_final.state_name,
	wrk.location_final.state_code,
	wrk.crime_score.score,
	wrk.park_score.score,
	wrk.jobs.numjobs,
	wrk.home_score.median_home_value
from wrk.location_final
inner join wrk.crime_score
	on wrk.location_final.state_name = wrk.crime_score.state_name
inner join wrk.park_score
	on wrk.location_final.city = wrk.park_score.city
inner join wrk.jobs
	on wrk.location_final.city = wrk.jobs.city
inner join wrk.home_score
	on wrk.home_score.city_id = wrk.location_final.city_id

	