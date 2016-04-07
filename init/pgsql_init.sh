# install postgresql
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib

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

#sudo chmod -R 777 /data/pgsql

#setup pg_hba.conf
sudo echo "host    all         all         0.0.0.0         0.0.0.0               md5" >> /data/pgsql/data/pg_hba.conf

#setup postgresql.conf
sudo echo "listen_addresses = '*'" >> /data/pgsql/data/postgresql.conf
sudo echo "standard_conforming_strings = off" >> /data/pgsql/data/postgresql.conf

#make start postgres file
sudo mkdir -p /data/scripts/pgsql
sudo chmod 777 /data/scripts/pgsql
sudo cat > /data/scripts/pgsql/start_postgres.sh <<EOF
#! /bin/bash
sudo service postgresql start
EOF
#sudo chmod 700 /data/scripts/pgsql/start_postgres.sh

#make a stop postgres file
sudo cat > /data/scripts/pgsql/stop_postgres.sh <<EOF
#! /bin/bash
sudo service postgresql stop
EOF
#sudo chmod 700 /data/scripts/pgsql/stop_postgres.sh

#sudo chmod 700 /data/pgsql/data

#start postgres
source /data/scripts/pgsql/start_postgres.sh