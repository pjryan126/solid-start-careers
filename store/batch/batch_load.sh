# create a source folder
sudo -u w205 hdfs dfs -mkdir /user/w205/src

# create a folder for each data set
sudo -u w205 hdfs dfs -mkdir /user/w205/src/crime_by_state
sudo -u w205 hdfs dfs -mkdir /user/w205/src/median_earnings
sudo -u w205 hdfs dfs -mkdir /user/w205/src/park_score
sudo -u w205 hdfs dfs -mkdir /user/w205/src/quality_of_life

# load source files into hdfs for long-term storage
sudo -u w205 hdfs dfs -put crime_by_state.csv /user/w205/src/crime_by_state
sudo -u w205 hdfs dfs -put median_earnings.csv /user/w205/src/median_earnings
sudo -u w205 hdfs dfs -put park_score.csv /user/w205/src/park_score
sudo -u w205 hdfs dfs -put quality_of_life.csv /user/w205/src/quality_of_life

# load source files into hive for accessible storage
pgsql -U postgres -f batch_load.sql