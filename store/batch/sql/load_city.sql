-- delete any data from raw.crime_stats staging table.
DELETE FROM raw.city;

-- make existing batch records for crime stats inactive
UPDATE src.batch b
SET is_active = FALSE
FROM src.datasource d
WHERE b.datasource_id = 8;

-- add src.batch record
INSERT INTO src.batch (datasource_id, name, is_active)
VALUES
  (8, :batch_name, TRUE);

-- load crime stats raw data
\copy raw.city_data FROM :f WITH DELIMITER AS ',' CSV HEADER QUOTE AS '"'

-- load crime stats raw data into src.crime_stats
INSERT INTO src.city_data (
  Region,
  State,
  Metro,
  County,
  Code
)
SELECT * FROM raw.city_data;

-- add batch_id to new records in src table
UPDATE src.city_data c
SET batch_id = b.batch_id
FROM src.batch b
WHERE c.batch_id IS NULL
  AND b.datasource_id = 8
  AND b.is_active = TRUE;

-- delete raw data from staging table
DELETE FROM raw.city_data;




