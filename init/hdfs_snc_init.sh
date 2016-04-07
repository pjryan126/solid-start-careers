#! /bin/bash

cd $HOME

########### install and configure hadoop ##############################

# create hadoop user and group
sudo addgroup hadoop &
sudo adduser --ingroup hadoop --gecos "" hdfs &
sudo adduser hdfs sudo &

# get updates
sudo apt-get update
sudo apt-get upgrade -y

# install jdk
sudo apt-get install openjdk-7-jdk -y
cd /usr/lib/jvm
sudo ln -s java-7-openjdk-amd64 jdk

# download and install cdh5
sudo mkdir -p ~/repository
sudo wget "http://archive.cloudera.com/cdh5/one-click-install/trusty/amd64/cdh5-repository_1.0_all.deb" \
	-O ~/repository/cdh5.deb
sudo dpkg -i ~/repository/cdh5.deb

# get repository key and install hadoop-conf-pseudo
sudo curl -s http://archive.cloudera.com/cdh5/ubuntu/lucid/amd64/cdh/archive.key | sudo apt-key add -
sudo apt-get update 
sudo apt-get install hadoop-conf-pseudo

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

