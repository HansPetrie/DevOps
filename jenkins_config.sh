#!/bin/bash

# Sleep allows Jenkins time to start up and extract itself
sleep 180
wget -O /var/lib/jenkins/plugins/aws-codepipeline-for-jenkins.hpi https://s3-us-west-2.amazonaws.com/publicrandomstuff/aws-codepipeline-for-jenkins.hpi
mkdir -p /var/lib/jenkins/jobs/MyDemoProject
cp config.xml /var/lib/jenkins/jobs/MyDemoProject
chown -R jenkins:jenkins /var/lib/jenkins/jobs/MyDemoProject
service jenkins restart

