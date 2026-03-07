#!/bin/bash
apt-get update -y
apt-get install -y openjdk-17-jdk awscli


aws s3 cp s3://my-project-artifacts-bucket/backend/app.jar /home/ubuntu/app.jar


nohup java -jar /home/ubuntu/app.jar > /home/ubuntu/app.log 2>&1 &