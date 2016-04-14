-- delete any data from raw.park_score staging table.
DELETE FROM raw.park_score;

-- make existing batch records for park score inactive
UPDATE src.batch b
SET is_active = FALSE
FROM src.datasource d
WHERE b.datasource_id = 2;

-- add src.batch record
INSERT INTO src.batch (datasource_id, name, is_active)
VALUES
  (2, batch_name, TRUE);


-- load park score raw data
\copy raw.park_score FROM '/data/batch/park_score.csv' WITH DELIMITER AS ',' CSV HEADER QUOTE AS '"'

-- load park score raw data into src.park_score
INSERT INTO src.park_score (
  city,
  state,
  year,
  score
)
SELECT * FROM raw.park_score;

-- add batch_id to new records in src table
UPDATE src.park_score p
SET p.batch_id = b.batch_id
FROM src.batch b
WHERE p.batch_id IS NULL
  AND b.datasource_id = 2
  AND b.is_active = TRUE;

-- delete raw data from staging table
DELETE FROM raw.park_score;




