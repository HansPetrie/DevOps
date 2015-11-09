#!/usr/bin/ruby

require 'erb'
require 'json'

template = (File.read("vpc.erb"))

n = JSON.parse(File.read("/tmp/jsonblob"))

renderer = ERB.new(template)

puts renderer.result()
