#!/bin/bash

wget -q -O /tmp/jenkins.rpm https://s3-us-west-2.amazonaws.com/publicrandomstuff/jenkins-1.609.3-1.1.noarch.rpm
rpm -i /tmp/jenkins.rpm 
service jenkins start
chkconfig jenkins on
sleep 10
#Allow Jenkins time to install
