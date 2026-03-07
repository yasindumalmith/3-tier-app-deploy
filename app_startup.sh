#!/bin/bash
apt-get update -y
apt-get install -y openjdk-17-jdk awscli

aws s3 cp s3://my-project-artifacts-bucket/backend/app.jar /home/ubuntu/app.jar

export DB_URL="jdbc:mysql://__DB_ENDPOINT__:3306/task_manager?createDatabaseIfNotExist=true&useSSL=false&allowPublicKeyRetrieval=true"
export DB_USER="__DB_USER__"
export DB_PASS="__DB_PASS__"

nohup java -jar /home/ubuntu/app.jar > /home/ubuntu/app.log 2>&1 &