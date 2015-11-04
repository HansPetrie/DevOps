#!/usr/bin/ruby

require 'json'

@region="us-east-1"
@filepath="/tmp/scope"

vpc_hash = JSON.parse(File.read("#{@filepath}/#{@region}-ec2-describe-vpcs"))
subnet_hash = JSON.parse(File.read("#{@filepath}/#{@region}-ec2-describe-subnets"))
instance_hash = JSON.parse(File.read("#{@filepath}/#{@region}-ec2-describe-instances"))
security_group_hash = JSON.parse(File.read("#{@filepath}/#{@region}-ec2-describe-security-groups"))
elb_hash = JSON.parse(File.read("#{@filepath}/#{@region}-elb-describe-load-balancers"))
rds_hash = JSON.parse(File.read("#{@filepath}/#{@region}-rds-describe-db-instances"))

vpc_hash['Vpcs'].each do |vpc|
  puts "-----------------------"
  puts "#{vpc['VpcId']} #{vpc['CidrBlock']}"
  if vpc['Tags']
    vpc['Tags'].each do |vpc_tags|
      puts "  #{vpc_tags['Key']} #{vpc_tags['Value']}"
    end
  end
  elbs_in_vpc = elb_hash['LoadBalancerDescriptions'].select { |key, hash| key["VPCId"] == vpc['VpcId'] } 
  elbs_in_vpc.each do |elb|
    puts "~~ELB #{elb['DNSName']}" 
    print "        "
    elb['Instances'].each do |elb_instance|
      print " #{elb_instance['InstanceId']}"
    end
    print "\n"
  end 
  rds_hash['DBInstances'].each do |db_instance|
    if db_instance['DBSubnetGroup']['VpcId'] == vpc['VpcId'] then 
      puts "**RDS #{db_instance['DBInstanceClass']} #{db_instance['AvailabilityZone']} #{db_instance['SecondaryAvailabilityZone']}"
    end
  end
  subnets_in_vpc = subnet_hash['Subnets'].select { |key, hash| key["VpcId"] == vpc['VpcId'] } 
  subnets_in_vpc.each do |subnet|
    puts "--#{subnet['SubnetId']} #{subnet['CidrBlock']} #{subnet['AvailabilityZone']}" 
    if subnet['Tags']
      subnet['Tags'].each do |subnet_tags|
        puts "      #{subnet_tags['Key']} #{subnet_tags['Value']}"
      end 
    end
    instance_hash['Reservations'].each do |reservation|
      instances_in_subnet = reservation['Instances'].select { |instance_key, instance_hash| instance_key['SubnetId'] == subnet['SubnetId'] }
      instances_in_subnet.each do |instance|
	puts "        #{instance["InstanceId"]} #{instance["InstanceType"]} #{instance["ImageId"]}"
	instance["SecurityGroups"].each do |security_group|
	  puts "             SecurityGroup: #{security_group['GroupName']}"
	  security_group_for_instance = security_group_hash["SecurityGroups"].select { |sg_key, sg_hash| sg_key["GroupId"] == security_group['GroupId'] }
            security_group_for_instance.first["IpPermissions"].each do |permissions|
		print "                            #{permissions['IpProtocol']} #{permissions['FromPort']} to #{permissions['ToPort']}"
	    		permissions["IpRanges"].each do |iprange|
			print " #{iprange["CidrIp"]}"
	    end	
            print "\n"
      	  end
	end
        if instance['Tags']
          instance['Tags'].each do |instance_tags|
            puts "             #{instance_tags['Key']} #{instance_tags['Value']}"
        end
       end
     end
  end
  end 
end
