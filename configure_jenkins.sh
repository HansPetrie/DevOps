#!/bin/bash

source devops.cnf

wget -q -O /tmp/aws-codepipeline-for-jenkins.hpi /aws-codepipeline-for-jenkins.hpi https://s3-us-west-2.amazonaws.com/publicrandomstuff/aws-codepipeline-for-jenkins.hpi

#Wait for Jenkins to come alive as it can take several minutes
until java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -s http://localhost:8080
do
  sleep 10
done

java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -s http://localhost:8080 install-plugin /tmp/aws-codepipeline-for-jenkins.hpi

sed "s|VERSION_STRING|$VersionString|g" config.xml > /tmp/config.xml

java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -s http://localhost:8080 create-job MyDemoProject < /tmp/config.xml
