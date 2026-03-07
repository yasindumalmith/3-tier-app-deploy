#!/bin/bash
apt-get update -y
apt-get install -y nginx awscli


systemctl start nginx
systemctl enable nginx


aws s3 cp s3://my-project-artifacts-bucket/frontend/ /var/www/html/ --recursive


systemctl restart nginx