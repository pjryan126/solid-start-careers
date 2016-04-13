# Setting Up the Data Warehouse

**1. Create an aws instance with the following AMI:**

AMI name:           UCB W205 Spring 2016
AMI ID:             ami-be0d5fd4
Region:             US East (N. Virginia)
Operating System:   Linux
Architecture:       64-bit
Root device type:   EBS
Launch Permission:  Public

**2. Create a security group with the following ports opened on 0.0.0.0/0:**
+ 22
+ 4040
+ 7180
+ 8080
+ 8088
+ 50070
+ 5432

**3. Navigate to the w205 user directory and clone the project repository:**

```
$ cd /home/w205
$ git clone https://github.com/pjryan126/solid-start-careers.git
```

**4. Install hadoop, postgresql, hive, and zeppelin.**

```
$ cd solid-start-careers
$ ./init.sh
```

**5. Start hadoop and postgresql.**

```
$ /root/start-hadoop.sh
$ /data/start_postgres.sh
```

**6. Set a password for user postgres on postresql server.**

```
$ pgsql -U postgres -d metastore
metastore=# alter user postgres with password 'password';
metastore=# \q
```

**6. Extract source files for batch load.**

```
$ cd store/batch
$ unzip batch.zip -d batch
```

**7. Load source files into hadoop.**

```
$ su - w205
$ ./batch_load.sh
```
