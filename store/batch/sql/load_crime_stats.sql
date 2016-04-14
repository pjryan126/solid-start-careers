-- delete any data from raw.crime_stats staging table.
DELETE FROM raw.crime_stats;

-- make existing batch records for crime stats inactive
UPDATE src.batch b
SET is_active = FALSE
FROM src.datasource d
WHERE b.datasource_id = 1;

-- add src.batch record
INSERT INTO src.batch (datasource_id, name, is_active)
VALUES
  (1, :batch_name, TRUE);

-- load crime stats raw data
\copy raw.crime_stats FROM '/data/batch/crime_by_state.csv' WITH DELIMITER AS ',' CSV HEADER QUOTE AS '"'

-- load crime stats raw data into src.crime_stats
INSERT INTO src.crime_stats (
  year,
  population,
  violent_crime_rate,
  homicide_rate,
  rape_rate,
  robbery_rate,
  aggr_assault_rate,
  property_crime_rate,
  burglary_rate,
  larceny_theft_rate,
  auto_theft_rate,
  state
)
SELECT * FROM raw.crime_stats;

-- add batch_id to new records in src table
UPDATE src.crime_stats c
SET batch_id = b.batch_id
FROM src.batch b
WHERE c.batch_id IS NULL
  AND b.datasource_id = 1
  AND b.is_active = TRUE;

-- delete raw data from staging table
DELETE FROM raw.crime_stats;




