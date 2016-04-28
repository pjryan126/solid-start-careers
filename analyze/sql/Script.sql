with jobs as 
(
	select 
		  j.city
		, j.state_code
		, j.category_name as job_category
		, avg(j.numJobs) as jobs_score
	from wrk.jobs_withCategory j
	group by 
		  j.city
		, j.state_code
		, j.category_name
),
stats as
(
select
	wrk.location_final.city as city,
	wrk.location_final.state_name as state_name,
	wrk.location_final.state_code as state_code,
	avg(wrk.crime_score.score) as crime_score,
	avg(wrk.park_score.score) as park_score,
	avg(wrk.home_score.median_home_value) as home_score
from wrk.location_final
inner join wrk.crime_score
	on wrk.location_final.state_name = wrk.crime_score.state_name
inner join wrk.park_score
	on wrk.location_final.city = wrk.park_score.city
inner join wrk.home_score
	on wrk.home_score.city_id = wrk.location_final.city_id
group by wrk.location_final.city, wrk.location_final.state_name, wrk.location_final.state_code
)
select
	  s.city
	, s.state_name
	, s.state_code
	, j.job_category
	, s.crime_score
	, s.park_score
	, j.jobs_score
	, s.home_score
from stats s
inner join jobs j
	on s.city = j.city
	and s.state_code = j.state_code
