#!/bin/bash

source devops.cnf

# Sleep allows Jenkins time to start up and extract itself
sleep 30 
wget -q -O /var/lib/jenkins/plugins/aws-codepipeline-for-jenkins.hpi https://s3-us-west-2.amazonaws.com/publicrandomstuff/aws-codepipeline-for-jenkins.hpi
mkdir -p /var/lib/jenkins/jobs/MyDemoProject

sed "s|VERSION_STRING|$VersionString|g" config.xml > /tmp/config.xml

cp /tmp/config.xml /var/lib/jenkins/jobs/MyDemoProject
chown -R jenkins:jenkins /var/lib/jenkins/jobs/MyDemoProject
service jenkins restart


sed "s|JENKINS_SERVER|$JenkinsHostname|g" custom_action_type.json > /tmp/custom_action_type.json
sed -i "s|VERSION_STRING|$VersionString|g" /tmp/custom_action_type.json
aws --region us-east-1 codepipeline create-custom-action-type --cli-input-json file:///tmp/custom_action_type.json

sed "s|VERSION_STRING|$VersionString|g" newpipeline.json > /tmp/newpipeline.json
sed -i "s|ROLEARN|$CodePipelineRoleArn|g" /tmp/newpipeline.json
sed -i "s|DEVOPSBUCKET|$DevopsBucketName|g" /tmp/newpipeline.json

aws --region us-east-1 codepipeline create-pipeline --cli-input-json file:///tmp/newpipeline.json
