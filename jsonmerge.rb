#!/usr/bin/ruby

require 'json'
require 'yaml'

@region="us-east-1"
@filepath="/tmp/scope"

vpc_hash = JSON.parse(File.read("#{@filepath}/#{@region}-ec2-describe-vpcs"))
subnet_hash = JSON.parse(File.read("#{@filepath}/#{@region}-ec2-describe-subnets"))
reservation_hash = JSON.parse(File.read("#{@filepath}/#{@region}-ec2-describe-instances"))
security_group_hash = JSON.parse(File.read("#{@filepath}/#{@region}-ec2-describe-security-groups"))
elb_hash = JSON.parse(File.read("#{@filepath}/#{@region}-elb-describe-load-balancers"))
rds_hash = JSON.parse(File.read("#{@filepath}/#{@region}-rds-describe-db-instances"))

instance_array = Array.new
instance_hash = Hash.new

reservation_hash['Reservations'].each do |reservation|
  reservation['Instances'].each do |instance|
    instance_array.push(instance)
  end
end

instance_hash=instance_hash.merge({"Instances" => instance_array})

vpc_hash['Vpcs'].each do |vpc|
  puts "---------------------------------------"
  elbs_in_vpc = elb_hash['LoadBalancerDescriptions'].select { |key, hash| key["VPCId"] == vpc['VpcId'] } 
  merged = vpc.merge({:ELB => elbs_in_vpc})
  puts vpc["Vpc_Id"]
  rds_array = Array.new 
  rds_hash['DBInstances'].each do |db_instance|
    if db_instance['DBSubnetGroup']['VpcId'] == vpc['VpcId'] then 
	rds_array.push(db_instance)	
    end
  end
  merged = merged.merge({:RDS => rds_array})
  subnets_in_vpc = subnet_hash['Subnets'].select { |key, hash| key["VpcId"] == vpc['VpcId'] } 
  subnet_array = Array.new 
  subnets_in_vpc.each do |subnet|
    instances_in_subnet = instance_hash['Instances'].select { |key, hash| key['SubnetId'] == subnet['SubnetId'] }
    subnet_merged = subnet.merge({:Instances => instances_in_subnet})
    subnet_array.push(subnet_merged)
  end
  merged = merged.merge({:Subnets => subnet_array})
  puts merged.to_yaml
end
