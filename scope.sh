#!/bin/bash

set -x 

mkdir -p /tmp/scope
rm -f /tmp/scope/*
IFS=$'\n' 

#regions=$(aws ec2 --region us-east-1 describe-regions --query Regions[*].[RegionName] --output text)

regions="us-east-1"

ec2commands="describe-instances
describe-availability-zones
describe-security-groups
describe-vpcs
describe-subnets
describe-route-tables"

ebcommands="describe-environments
describe-applications
describe-configuration-options"

for region in $regions; do
  for command in $ec2commands; do
    aws ec2 --region $region $command > /tmp/scope/ec2-$region-$command.json
  done 
  for command in $ebcommands; do
    aws elasticbeanstalk --region $region $command > /tmp/scope/eb-$region-$command.json 
  done

  environments=$(aws --region $region elasticbeanstalk describe-environments --query Environments[*].[EnvironmentName] --output text)
  for environment in $environments; do
    applications=$(aws --region $region elasticbeanstalk describe-environments --environment-name $environment --query Environments[*].[ApplicationName] --output text)
    for application in $applications; do
      aws --region $region elasticbeanstalk describe-configuration-settings --application-name $application --environment-name $environment > /tmp/scope/eb-$region-configuration-settings-$environment-$application
    done
  done
done