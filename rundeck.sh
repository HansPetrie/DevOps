#!/bin/bash

rpm -Uvh https://s3-us-west-2.amazonaws.com/publicrandomstuff/rundeck.rpm
yum -y install rundeck
service rundeckd start
chkconfig rundeckd on
