-- delete any data from raw.crime_stats staging table.
DELETE FROM raw.quality_of_life;

-- make existing batch records for quality of life inactive
UPDATE src.batch b
SET is_active = FALSE
FROM src.datasource d
WHERE b.datasource_id = 3;

-- add src.batch record
INSERT INTO src.batch (datasource_id, name, is_active)
VALUES
  (3, :batch_name, TRUE);


-- load quality of life raw data
\copy raw.quality_of_life FROM :f WITH DELIMITER AS ',' CSV HEADER QUOTE AS '"'

-- load quality of life raw data into src.quality_of_life
INSERT INTO src.quality_of_life (
  Year,
  LocationAbbr,
  LocationDesc,
  Category,
  Topic,
  Question,
  DataSource,
  Data_Value_Unit,
  Data_Value_Type,
  Data_Value,
  Data_Value_Footnote_Symbol,
  Data_Value_Footnote,
  Data_Value_Std_Err,
  Low_Confidence_Limit,
  High_Confidence_Limit,
  Sample_Size,
  Break_Out,
  Break_Out_Category,
  GeoLocation,
  CategoryId,
  TopicId,
  QuestionId,
  LocationId,
  BreakOutId,
  BreakOutCategoryid
)
SELECT * FROM raw.quality_of_life;

-- add batch_id to new records in src table
UPDATE src.quality_of_life q
SET batch_id = b.batch_id
FROM src.batch b
WHERE q.batch_id IS NULL
  AND b.datasource_id = 3
  AND b.is_active = TRUE;

-- delete raw data from staging table
DELETE FROM raw.quality_of_life;




