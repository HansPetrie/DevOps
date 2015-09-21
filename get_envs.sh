#!/bin/bash

source devops.cnf

aws --region us-east-1 cloudformation describe-stacks --stack-name $CloudformationStackName --output text --query Stacks[*].Parameters[*].[ParameterKey,ParameterValue] > /tmp/envs
aws --region us-east-1 cloudformation describe-stacks --stack-name $CloudformationStackName --output text --query Stacks[*].Outputs[*].[OutputKey,OutputValue] >> /tmp/envs
sed 's/\t/=/g' /tmp/envs >> devops.cnf

echo "JenkinsHostname=$(curl -s 169.254.169.254/latest/meta-data/public-hostname/)" >> devops.cnf
echo "VersionString=$(date +%m%d%H%M)" >> devops.cnf
