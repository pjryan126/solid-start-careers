-- delete any data from raw.crime_stats staging table.
DELETE FROM raw.job_category;

-- make existing batch records for crime stats inactive
UPDATE src.batch b
SET is_active = FALSE
FROM src.datasource d
WHERE b.datasource_id = 9;

-- add src.batch record
INSERT INTO src.batch (datasource_id, name, is_active)
VALUES
  (9, :batch_name, TRUE);

-- load crime stats raw data
\copy raw.job_category FROM :f WITH DELIMITER AS ',' CSV HEADER QUOTE AS '"'

-- load crime stats raw data into src.crime_stats
INSERT INTO src.job_category (
  category_id,
  name
)
SELECT 
	CAST(category_id AS INT) AS category_id,
	name
	FROM raw.job_category;

-- add batch_id to new records in src table
UPDATE src.job_category c
SET batch_id = b.batch_id
FROM src.batch b
WHERE c.batch_id IS NULL
  AND b.datasource_id = 9
  AND b.is_active = TRUE;

-- delete raw data from staging table
DELETE FROM raw.job_category;




