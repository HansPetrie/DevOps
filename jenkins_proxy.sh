#!/bin/bash

yum -y install httpd
cp rendered_templates/jenkins.conf /etc/httpd/conf.d
service httpd restart
chkconfig httpd on
