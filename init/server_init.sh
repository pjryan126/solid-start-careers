#! /bin/bash

########### mount drive specified by user to /data directory ##########
cd $HOME
sudo mkdir -p /data/scripts
sudo umount /data
echo "mounting drive: " $1
echo "WARNING: This will format the above drive."
read -rsp $'Press any key to continue or Ctrl-C to quit...\n' -n1 key

# make new ext4 filesystem
sudo mkfs -t ext4 /dev/xvdf

# mount new filesystem
sudo mount -t ext4 $1 /data
sudo chmod a+rwx /data

########### end mount drive specified by user to /data directory ######

source hdfs_snc_init.sh &
source ~/pgsql_init.sh

# create start/stop scripts
sudo mkdir /data/scripts
sudo chmod a+w /data/scripts

# create start_hdfs script
sudo cat > /data/scripts/start_hdfs.sh <<EOF
#! /bin/bash
sudo service hadoop-yarn-resourcemanager restart
sudo service hadoop-yarn-nodemanager restart 
sudo service hadoop-mapreduce-historyserver restart
EOF
sudo chmod +x /data/scripts/start_hdfs.sh

# create stop_hdfs script
sudo cat > /data/scripts/stop_hdfs.sh <<EOF
#! /bin/bash
sudo service hadoop-yarn-resourcemanager stop
sudo service hadoop-yarn-nodemanager stop 
sudo service hadoop-mapreduce-historyserver stop
EOF
sudo chmod +x /data/scripts/stop_hdfs.sh

# create start_postgres script
sudo cat > /data/scripts/start_postgres.sh <<EOF
#! /bin/bash
sudo -u postgres pg_ctl -D /data/pgsql/data -l /data/pgsql/logs/pgsql.log start
EOF
sudo chmod +x /data/scripts/start_postgres.sh

#make a stop postgres file
sudo cat > /data/scripts/stop_postgres.sh <<EOF
#! /bin/bash
sudo -u postgres pg_ctl -D /data/pgsql/data -l /data/pgsql/logs/pgsql.log stop
EOF
sudo chmod +x /data/scripts/stop_postgres.sh

# start yarn services
/data/scripts/start_hdfs.sh

#start postgres
/data/scripts/start_postgres.sh

