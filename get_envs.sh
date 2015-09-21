#!/bin/bash

aws --region us-east-1 cloudformation describe-stacks --stack-name DevOps2 --output text --query Stacks[*].Parameters[*].[ParameterKey,ParameterValue] > /tmp/envs
aws --region us-east-1 cloudformation describe-stacks --stack-name DevOps2 --output text --query Stacks[*].Outputs[*].[OutputKey,OutputValue] >> /tmp/envs
sed 's/\t/=/g' /tmp/envs >> devops.cnf

echo "jenkins_hostname=$(curl -s 169.254.169.254/latest/meta-data/public-hostname/)" >> devops.cnf
echo "version_string=$(date +%m%d%H%M)" >> devops.cnf
