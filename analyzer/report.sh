#!/bin/bash

#./scope.sh
./jsonmerge.rb devops us-east-1 awsreport > awsreport/devops-us-east-1.json
./jsonmerge.rb qa us-east-1 awsreport > awsreport/qa-us-east-1.json
./jsonmerge.rb production us-east-1 awsreport > awsreport/prod-us-east-1.json

./analyzer.rb awsreport/devops-us-east-1.json > awsreport/devops.txt
./analyzer.rb awsreport/qa-us-east-1.json > awsreport/qa.txt
./analyzer.rb awsreport/prod-us-east-1.json > awsreport/prod.txt
