#!/bin/bash
apt-get update -y
apt-get install -y nginx awscli

systemctl start nginx
systemctl enable nginx

aws s3 cp s3://my-project-artifacts-bucket/frontend/ /var/www/html/ --recursive

find /var/www/html/ -type f -name "*.js" -exec sed -i "s|__APP_ALB_DNS__|__APP_ALB_DNS__|g" {} +

systemctl restart nginx