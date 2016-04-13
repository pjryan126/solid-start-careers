# Step-by-Step Instructions for Setting Up and Loading Source Data to Data Warehouse

**1. Create an aws instance with the following AMI:

AMI name:           UCB W205 Spring 2016
AMI ID:             ami-be0d5fd4
Region:             US East (N. Virginia)
Operating System:   Linux
Architecture:       64-bit
Root device type:   EBS
Launch Permission:  Public

2. Create a security group with the following ports opened on 0.0.0.0/0:
+ 22
+ 4040
+ 7180
+ 8080
+ 8088
+ 50070

3. Navigate to the w205 user directory and clone the project repository:

```
$ cd /home/w205
$ git clone https://github.com/pjryan126/solid-start-careers.git
```

4. Instantiate the server by installing hadoop, postgresql, hive, and zeppelin.

```
$ cd solid-start-careers
$ ./init.sh
```

5. Start hadoop and postgresql

```
$ /root/start-hadoop.sh
$ /root/start_postgres.sh
```

6. Extract source files for batch load:

```
$ cd data/src/batch
$ unzip batch.zip
```

7. Load source files into hadoop.

```
$ ./batch_load.sh
