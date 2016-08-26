#!/usr/bin/ruby

require 'json'

@filepath=ARGV[0]

input_hash = JSON.parse(File.read("#{@filepath}"))

input_hash['VPC'].each do |vpc|
  puts "-----------------------"
  puts "#{vpc['VpcId']} #{vpc['CidrBlock']}"
  if vpc['Tags']
    vpc['Tags'].each do |vpc_tags|
      puts "#{vpc_tags['Key']}:#{vpc_tags['Value']}"
    end
  end
  vpc['ELB'].each do |elb|
    puts "#{elb['DNSName']}"
  end
end
