#!/bin/bash

sudo yum -y install httpd
sudo cp jenkins.conf /etc/httpd/conf.d
sudo service httpd restart
sudo chkconfig httpd on
