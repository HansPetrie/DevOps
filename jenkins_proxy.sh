#!/bin/bash

sudo yum -y install httpd
sudo cp jenkins.conf /etc/httpd/conf.d
service httpd restart
chkconfig httpd on
