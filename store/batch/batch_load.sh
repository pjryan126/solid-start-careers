# create a source folder
sudo -u w205 hdfs dfs -mkdir /user/w205/src

# create a folder for each source file
sudo -u w205 hdfs dfs -mkdir /user/w205/src/crime_by_state
sudo -u w205 hdfs dfs -mkdir /user/w205/src/median_earnings
sudo -u w205 hdfs dfs -mkdir /user/w205/src/park_score
sudo -u w205 hdfs dfs -mkdir /user/w205/src/quality_of_life
sudo -u w205 hdfs dfs -mkdir /user/w205/src/jobs_data
sudo -u w205 hdfs dfs -mkdir /user/w205/src/housing_data
sudo -u w205 hdfs dfs -mkdir /user/w205/src/job_category



# load batch source files into hdfs for long-term storage
sudo -u w205 hdfs dfs -put /data/batch/crime_by_state.csv /user/w205/src/crime_by_state
sudo -u w205 hdfs dfs -put /data/batch/median_earnings.csv /user/w205/src/median_earnings
sudo -u w205 hdfs dfs -put /data/batch/park_score.csv /user/w205/src/park_score
sudo -u w205 hdfs dfs -put /data/batch/quality_of_life.csv /user/w205/src/quality_of_life
sudo -u w205 hdfs dfs -put /data/batch/job_category.csv /user/w205/src/job_category

# load batch source files into postgresql for accessible storage
psql -U postgres -d solid_start -v batch_name="'Location 1'" -v f="'/data/batch/location.csv'" \
-f /data/sql/load_location.sql
psql -U postgres -d solid_start -v batch_name="'Crime Stats 1'" -v f="'/data/batch/crime_by_state.csv'" \
-f /data/sql/load_crime_stats.sql
psql -U postgres -d solid_start -v batch_name="'Park Score 1'" -v f="'/data/batch/park_score.csv'" \
-f /data/sql/load_park_score.sql
psql -U postgres -d solid_start -v batch_name="'Quality of Life 1'" -v f="'/data/batch/quality_of_life.csv'" \
-f /data/sql/load_quality_of_life.sql
psql -U postgres -d solid_start -v batch_name="'Median Earnings 1'" -v f="'/data/batch/median_earnings.csv'" \
-f /data/sql/load_median_earnings.sql
psql -U postgres -d solid_start -v batch_name="'Job Categories 1'" -v f="'/data/batch/job_category.csv'" \
-f /data/sql/load_job_category.sql
