#!/bin/bash

STACKNAME=RDSMysql$(date +%Y%m%d%H%M%S)

aws --region us-west-2 cloudformation create-stack --stack-name $STACKNAME --template-body file://teststack.json --capabilities CAPABILITY_IAM 

exit 0

while [ `aws --region us-east-2 cloudformation describe-stacks --stack-name $STACKNAME --output text --query 'Stacks[*].[StackStatus]'` != "CREATE_COMPLETE" ]
do
  sleep 30
  echo "Stack Building." 
done

aws --region us-east-2 cloudformation describe-stacks --stack-name $STACKNAME --output text --query 'Stacks[*].Outputs[*].OutputValue'
