#!/bin/bash


apt-get update -y
apt-get install -y openjdk-17-jdk unzip curl


curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install


/usr/local/bin/aws s3 cp s3://3-tier-s3-bucket-yasa/backend/app.jar /home/ubuntu/app.jar

export DB_URL="jdbc:mysql://__DB_ENDPOINT__/task_manager?createDatabaseIfNotExist=true&useSSL=false&allowPublicKeyRetrieval=true"
export DB_USER="__DB_USER__"
export DB_PASS="__DB_PASS__"

chown ubuntu:ubuntu /home/ubuntu/app.jar

nohup java -jar /home/ubuntu/app.jar > /home/ubuntu/app.log 2>&1 &