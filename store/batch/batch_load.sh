# switch to w205 user
su - w205

# create a folder for each data set
hdfs dfs ‐mkdir /user/w205/src/crime_by_state
hdfs dfs ‐mkdir /user/w205/src/median_earnings
hdfs dfs ‐mkdir /user/w205/src/park_score
hdfs dfs ‐mkdir /user/w205/src/quality_of_life

# load source files into hdfs for long-term storage
hdfs dfs -put crime_by_state.csv /user/w205/src/crime_by_state
hdfs dfs ‐put median_earnings.csv /user/w205/src/median_earnings
hdfs dfs ‐put park_score.csv /user/w205/src/park_score
hdfs dfs ‐put quality_of_life.csv /user/w205/src/quality_of_life

# load source files into hive for accessible storage
hive -f ./hive_batch_ddl.hql


