#!/usr/bin/ruby

require 'json'

vpc_hash = JSON.parse(File.read('ec2-us-east-1-describe-vpcs.json'))
subnet_hash = JSON.parse(File.read('ec2-us-east-1-describe-subnets.json'))
instance_hash = JSON.parse(File.read('ec2-us-east-1-describe-instances.json'))
security_group_hash = JSON.parse(File.read('ec2-us-east-1-describe-security-groups.json'))

vpc_hash['Vpcs'].each do |vpc|
  puts "-----------------------"
  puts "#{vpc['VpcId']} #{vpc['CidrBlock']}"
  if vpc['Tags']
    vpc['Tags'].each do |vpc_tags|
      puts "  #{vpc_tags['Key']} #{vpc_tags['Value']}"
    end
  end 
  subnets_in_vpc = subnet_hash['Subnets'].select { |key, hash| key["VpcId"] == vpc['VpcId'] } 
  subnets_in_vpc.each do |subnet|
    puts "  --#{subnet['SubnetId']} #{subnet['CidrBlock']} #{subnet['AvailabilityZone']}" 
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
	  #security_group_for_instance = security_group_hash["SecurityGroups"].select { |sg_key, sg_hash| sg_key["GroupId"] == security_group['GroupId'] }
          #security_group_for_instance.first["IpPermissions"].each do |permissions|
		#puts "                                  #{permissions['FromPort']}:#{permissions['ToPort']}"
	    #permissions["IpRanges"].each do |iprange|
#		puts iprange["CidrIp"]
#	    end	
    #  	  end
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
