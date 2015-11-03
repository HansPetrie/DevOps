#!/bin/bash -e

mkdir -p /tmp/scope
rm -f /tmp/scope/*
IFS=$'\n' 

#regions=$(aws ec2 --region us-east-1 describe-regions --query Regions[*].[RegionName] --output text)

regions="us-east-1"

commands="ec2 describe-account-attributes
ec2 describe-addresses
ec2 describe-availability-zones
ec2 describe-instances
ec2 describe-internet-gateways
ec2 describe-key-pairs
ec2 describe-network-acls
ec2 describe-network-interfaces
ec2 describe-placement-groups
ec2 describe-reserved-instances
ec2 describe-route-tables
ec2 describe-security-groups
ec2 describe-subnets
ec2 describe-tags
ec2 describe-volumes
ec2 describe-vpcs
elb describe-load-balancers
rds describe-db-instances
elasticbeanstalk describe-environments
elasticbeanstalk describe-applications
elasticbeanstalk describe-configuration-options
"

for region in $regions; do
  for command in $commands; do
    filename=$(echo $command | sed 's/ /-/g' )
    echo "aws --region $region $command > /tmp/scope/$region-$filename"
    bash -c "aws --output json --region $region $command > /tmp/scope/$region-$filename"
  done
done
