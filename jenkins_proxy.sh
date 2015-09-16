#!/bin/bash

yum -y install httpd
cp jenkins.conf /etc/httpd/conf.d
service httpd restart
chkconfig httpd on
