#!/bin/bash

now="$(date)"
printf "Start time : %s\n" "$now"

cd /dev/shm
shred -u */*
shred -u *
rm -rf /dev/shm/*

# Mounting app for all logs
sudo mkdir /app
sudo mkfs /dev/xvdb
sudo mount /dev/xvdb /app

#sudo aws s3 cp s3://idc-aws-session/health.conf health.conf
#sudo aws s3 cp s3://idc-aws-session/rewrite-global.conf rewrite-global.conf
#sudo aws s3 cp s3://idc-aws-session/index.html index.html
#sudo aws s3 cp s3://idc-aws-session/httpd-vhost.conf httpd-vhost.conf
#sudo aws s3 cp s3://idc-aws-session/httpd.conf httpd.conf
#sudo aws s3 cp s3://idc-aws-session/logFormat.conf logFormat.conf
#sudo aws s3 cp s3://idc-aws-session/mod_security.conf mod_security.conf
#sudo aws s3 cp s3://idc-aws-session/httpd httpd

wget http://idc-aws-session.s3-website-us-west-2.amazonaws.com/health.conf
wget http://idc-aws-session.s3-website-us-west-2.amazonaws.com/rewrite-global.conf
wget http://idc-aws-session.s3-website-us-west-2.amazonaws.com/index.html
wget http://idc-aws-session.s3-website-us-west-2.amazonaws.com/httpd-vhost.conf
wget http://idc-aws-session.s3-website-us-west-2.amazonaws.com/httpd.conf
wget http://idc-aws-session.s3-website-us-west-2.amazonaws.com/logFormat.conf
wget http://idc-aws-session.s3-website-us-west-2.amazonaws.com/mod_security.conf
wget http://idc-aws-session.s3-website-us-west-2.amazonaws.com/httpd

#sudo aws s3 cp s3://idc-aws-session/ssl.conf ssl.conf



sudo yum install httpd-2.4.6 -y
sudo yum install mod_ssl -y
sudo yum install mod_security -y


sudo cp health.conf /etc/httpd/conf.d/
sudo cp rewrite-global.conf /etc/httpd/conf.d/
sudo cp index.html /var/www/html/
sudo cp httpd-vhost.conf /etc/httpd/conf.d/
sudo cp httpd.conf /etc/httpd/conf/
sudo cp logFormat.conf /etc/httpd/conf.d/logFormat.conf
#sudo cp ssl.conf /etc/httpd/conf.d/ssl.conf
sudo rm -rf /etc/httpd/conf.d/mod_security.conf
sudo cp mod_security.conf /etc/httpd/conf.d/mod_security.conf
sudo rm -rf /etc/logrotate.d/httpd
sudo cp httpd /etc/logrotate.d/httpd
sudo rm -rf /etc/httpd/conf.modules.d/01-cgi.conf

chmod 777 /var/www/html/index.html
sudo chmod 775 /etc/logrotate.d/httpd
sudo chmod 664 /etc/httpd/conf.d/ -R

mkdir -p /app/var/log/httpd/redirect
sudo ln -s /app/var/log/httpd /sbglogs

#start HTTPD
service httpd start


now="$(date)"
printf "End time : %s\n" "$now"
