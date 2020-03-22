#!/bin/bash
apt-get update -y
apt-get install apache2 -y
apt-get install git -y
wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add -
apt-get install salt-master -y
apt-get install salt-minion -y
apt-get install salt-ssh -y
apt-get install salt-syndic -y
apt-get install salt-cloud -y
apt-get install salt-api -y
service enable apache2
service apache2 start
echo "Welcome to salt-master-minion EC2 instance Web Server" > /var/www/html/index.html
chmod 666 /var/www/html/index.html
