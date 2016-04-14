-- delete any data from raw.crime_stats staging table.
DELETE FROM raw.location;

-- make existing batch records for location inactive
UPDATE src.batch b
SET is_active = FALSE
FROM src.datasource d
WHERE b.datasource_id = 7;

-- add src.batch record
INSERT INTO src.batch (datasource_id, name, is_active)
VALUES
  (7, :batch_name, TRUE);

-- load location raw data
\copy raw.location FROM :f WITH DELIMITER AS ',' CSV HEADER QUOTE AS '"'

-- load location raw data into src.location
INSERT INTO src.location (
  zip_code,
  latitude,
  longitude,
  city,
  state,
  county
)
SELECT * FROM raw.location;

-- add batch_id to new records in src table
UPDATE src.location l
SET batch_id = b.batch_id
FROM src.batch b
WHERE l.batch_id IS NULL
  AND b.datasource_id = 7
  AND b.is_active = TRUE;

-- delete raw data from staging table
DELETE FROM raw.location;




