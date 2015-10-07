#!/bin/bash

STACKNAME=RDSWordpress

aws --region us-west-2 cloudformation create-stack --stack-name $STACKNAME --template-body file://teststack.json --capabilities CAPABILITY_IAM 

while [ `aws --region us-west-2 cloudformation describe-stacks --stack-name $STACKNAME --output text --query 'Stacks[*].[StackStatus]'` != "CREATE_COMPLETE" ]
do
  sleep 30
  echo "Stack Building." 
done

aws --region us-west-2 cloudformation describe-stacks --stack-name $STACKNAME --output text --query 'Stacks[*].Outputs[*].OutputValue'