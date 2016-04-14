-- load crime stats source data
\copy src.crime_stats FROM '/data/batch/crime_by_state.csv' WITH DELIMITER AS ',' CSV HEADER QUOTE AS '"'
-- load park score source data
\copy src.park_score FROM '/data/batch/park_score.csv' WITH DELIMITER AS ',' CSV HEADER QUOTE AS '"'
-- load quality of life source data
\copy src.quality_of_life FROM '/data/batch/quality_of_life.csv' WITH DELIMITER AS ',' CSV HEADER QUOTE AS '"'
-- load median earnings source data
\copy src.median_earnings FROM '/data/batch/median_earnings.csv' WITH DELIMITER AS ',' CSV HEADER QUOTE AS '"'

