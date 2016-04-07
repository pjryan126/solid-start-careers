#! /bin/bash

# create hadoop user and group
sudo addgroup hadoop &&
sudo adduser --ingroup hadoop hdfs &&
sudo adduser hdfs sudo &&

########### mount drive specified by user to /data directory ##########
echo "mounting drive: " $1
echo "WARNING: This will format the above drive."
read -rsp $'Press any key to continue or Ctrl-C to quit...\n' -n1 key

# make new ext4 filesystem
sudo mkfs -t ext4 /dev/xvdf

# mount new filesystem
sudo mount -t ext4 $1 /data
sudo chmod a+rwx /data

########### end mount drive specified by user to /data directory ######

########### install packages ##############################

# download and install cdh5
sudo mkdir -p ~/repository
sudo wget "http://archive.cloudera.com/cdh5/one-click-install/trusty/amd64/cdh5-repository_1.0_all.deb" \
	-O ~/repository/cdh5.deb
sudo dpkg -i ~/repository/cdh5.deb
# get repository key and install hadoop-conf-pseudo
sudo curl -s http://archive.cloudera.com/cdh5/ubuntu/lucid/amd64/cdh/archive.key | sudo apt-key add -

# update packages
sudo apt-get update

# install jdk
sudo apt-get install openjdk-7-jdk -y
cd /usr/lib/jvm
sudo ln -s java-7-openjdk-amd64 jdk
#install hadoop
sudo apt-get install hadoop-conf-pseudo -y
# install postgresql
sudo apt-get install postgresql postgresql-contrib -y

########### end install packages ##############################

########### configure hadoop ##############################

HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop
# create backup copies of original Hadoop config files
sudo cp -n $HADOOP_CONF_DIR/hadoop-env.sh $HADOOP_CONF_DIR/hadoop-env.sh.backup
sudo cp -n $HADOOP_CONF_DIR/core-site.xml $HADOOP_CONF_DIR/core-site.xml.backup
sudo cp -n $HADOOP_CONF_DIR/yarn-site.xml $HADOOP_CONF_DIR/yarn-site.xml.backup
sudo cp -n $HADOOP_CONF_DIR/hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml.backup

# restore config files to original versions
sudo cp -n $HADOOP_CONF_DIR/hadoop-env.sh.backup $HADOOP_CONF_DIR/hadoop-env.sh
sudo cp $HADOOP_CONF_DIR/core-site.xml.backup $HADOOP_CONF_DIR/core-site.xml
sudo cp $HADOOP_CONF_DIR/yarn-site.xml.backup $HADOOP_CONF_DIR/yarn-site.xml 
sudo cp $HADOOP_CONF_DIR/hdfs-site.xml.backup $HADOOP_CONF_DIR/hdfs-site.xml
sudo cp $HADOOP_CONF_DIR/mapred-site.xml.template $HADOOP_CONF_DIR/mapred-site.xml 

# modify hadoop-env config file
sudo chmod 755 $HADOOP_CONF_DIR/hadoop-env.sh
sudo sed -i 's|export JAVA_HOME=${JAVA_HOME}|export JAVA_HOME=\/usr\/lib\/jvm\/jdk\n|' $HADOOP_CONF_DIR/hadoop-env.sh

# modify core-site config file
TAG="<property>\n<name>fs.default.name</name>\n<value>hdfs://localhost:9000</value>\n</property>"
C=$(echo $TAG | sed 's/\//\\\//g')
sudo sed -i "/<\/configuration>/ s/.*/${C}\n&/" $HADOOP_CONF_DIR/core-site.xml

# modify yarn-site config file
TAG="<property>\n<name>yarn.nodemanager.aux-services</name>\n<value>mapreduce_shuffle</value>\n</property>\n"
TAG="$TAG<property>\n<name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>\n"
TAG="$TAG<value>org.apache.hadoop.mapred.ShuffleHandler</value>\n</property>"
C=$(echo $TAG | sed 's/\//\\\//g')
sudo sed -i "/<\/configuration>/ s/.*/${C}\n&/" $HADOOP_CONF_DIR/yarn-site.xml

# modify mapred-site config file
TAG="<property>\n<name>mapreduce.framework.name</name>\n"
TAG="$TAG<value>yarn</value>\n</property>"
C=$(echo $TAG | sed 's/\//\\\//g')
sudo sed -i "/<\/configuration>/ s/.*/${C}\n&/" $HADOOP_CONF_DIR/mapred-site.xml

# modify hdfs-site config file
TAG="<property>\n<name>dfs.replication</name>\n<value>1</value>\n</property>\n<property>\n"
TAG="$TAG<name>dfs.namenode.name.dir</name>\n<value>file:/data/hadoop_store/hdfs/namenode</value>"
TAG="$TAG\n</property>\n<property>\n<name>dfs.datanode.data.dir</name>\n"
TAG="$TAG<value>file:/data/hadoop_store/hdfs/datanode</value>\n</property>"
C=$(echo $TAG | sed 's/\//\\\//g')
sudo sed -i "/<\/configuration>/ s/.*/${C}\n&/" $HADOOP_CONF_DIR/hdfs-site.xml

# create namenode and datanode directories
sudo rm -R /data/hadoop_store
sudo mkdir -p /data/hadoop_store/hdfs/namenode
sudo mkdir -p /data/hadoop_store/hdfs/datanode

# grant owner and permissions to correct user
sudo chown -R hdfs:hadoop /usr/local/hadoop
sudo chmod -R 777 /usr/local/hadoop
sudo chown -R hdfs:hadoop /data/hadoop_store
sudo chmod -R 777 /data/hadoop_store

# format the namenode
sudo su - hdfs -c "hdfs namenode -format" &

########### end configure hadoop ##############################

########### configure postgres ##############################

#set up directories for postgres
sudo rm -R /data/pgsql
sudo mkdir -p /data/pgsql/data
sudo mkdir -p /data/pgsql/logs
sudo chown -R postgres:postgres /data/pgsql

# drop and recreate pgsql cluser
sudo pg_dropcluster --stop 9.3 main
sudo pg_createcluster -d /data/pgsql/data 9.3 main

# change pgsql data directory in config file
PGSQL_CONF_DIR=/etc/postgresql/9.3/main
sudo -u postgres cp -n $PGSQL_CONF_DIR/postgresql.conf $PGSQL_CONF_DIR/postgresql.conf.backup
sudo -u postgres cp $PGSQL_CONF_DIR/postgresql.conf.backup $PGSQL_CONF_DIR/postgresql.conf
sudo sed -i "s|data_directory = '/var/lib/postgresql/9.3/main'|data_directory = '/data/pgsql/data'|" $PGSQL_CONF_DIR/postgresql.conf 

#setup pg_hba.conf
sudo echo "host    all         all         0.0.0.0         0.0.0.0               md5" >> /data/pgsql/data/pg_hba.conf

#setup postgresql.conf
sudo echo "listen_addresses = '*'" >> /data/pgsql/data/postgresql.conf
sudo echo "standard_conforming_strings = off" >> /data/pgsql/data/postgresql.conf

#make start postgres file
sudo mkdir -p /data/scripts/pgsql
sudo mkdir -p /data/scripts/hdfs
sudo chmod -R 777 /data/scripts/

########### end configure postgres ##############################

########### create start/stop scripts ##############################

#make start script directories
sudo mkdir -p /data/scripts/pgsql
sudo mkdir -p /data/scripts/hdfs
sudo chmod -R 777 /data/scripts/

# create start_hdfs script
sudo cat > /data/scripts/hdfs/start_hdfs.sh <<EOF
#! /bin/bash
sudo service hadoop-yarn-resourcemanager restart
sudo service hadoop-yarn-nodemanager restart 
sudo service hadoop-mapreduce-historyserver restart
EOF
sudo chmod +x /data/scripts/start_hdfs.sh &

# create stop_hdfs script
sudo cat > /data/scripts/hdfs/stop_hdfs.sh <<EOF
#! /bin/bash
sudo service hadoop-yarn-resourcemanager stop
sudo service hadoop-yarn-nodemanager stop 
sudo service hadoop-mapreduce-historyserver stop
EOF
#sudo chmod +x /data/scripts/hdfs/stop_hdfs.sh &

# create start_postgres script
sudo cat > /data/scripts/pgsql/start_postgres.sh <<EOF
#! /bin/bash
sudo -u postgres pg_ctl -D /data/pgsql/data -l /data/pgsql/logs/pgsql.log start
EOF
#sudo chmod +x /data/scripts/start_postgres.sh &

#make a stop postgres file
sudo cat > /data/scripts/pgsql/stop_postgres.sh <<EOF
#! /bin/bash
sudo -u postgres pg_ctl -D /data/pgsql/data -l /data/pgsql/logs/pgsql.log stop
EOF
#sudo chmod +x /data/scripts/stop_postgres.sh &

########### end create start/stop scripts ##############################

########### start hadoop & postgres ####################################

# start hdfs
for x in `cd /etc/init.d ; ls hadoop-hdfs*` ; do sudo service $x start ; done

# create hdfs directories
sudo /usr/lib/hadoop/libexec/init-hdfs.sh &

# add user directories
sudo su -s /bin/bash hdfs -c "/usr/bin/hadoop fs -mkdir /user/hdfs"
sudo su -s /bin/bash hdfs -c "/usr/bin/hadoop fs -chown hdfs:hadoop /user/hdfs"

# start yarn services
sudo service hadoop-yarn-resourcemanager stop
sudo service hadoop-yarn-nodemanager stop
sudo service hadoop-mapreduce-historyserver stop
sudo service hadoop-yarn-resourcemanager start
sudo service hadoop-yarn-nodemanager start 
sudo service hadoop-mapreduce-historyserver start

#start postgres
/data/scripts/pgsql/start_postgres.sh

