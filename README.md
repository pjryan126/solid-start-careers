# solid-start-careers
w205 Final Project -- An application for helping recent graduates find the best places to live and work after school.

# Setup 
1. Create an aws instance with the following AMI:

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

5. Extract source files for batch load:

```
$ cd data/src/batch
$ unzip batch.zip
```
