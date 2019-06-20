#!/bin/bash

wget -q -O /tmp/jenkins.rpm https://s3-us-west-2.amazonaws.com/cloudlord.com/devops/jenkins-2.181-1.1.noarch.rpm
yum -y remove java
yum update
yum -y install java-1.8.0-openjdk
rpm -i /tmp/jenkins.rpm 
service jenkins start
chkconfig jenkins on
