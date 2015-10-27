#!/bin/bash

REGION="us-east-1"
STACKNAME="DevOps"

aws --region $REGION cloudformation delete-stack --stack-name $STACKNAME

while aws --region $REGION cloudformation describe-stacks --stack-name $STACKNAME
do
  sleep 30
  echo "Stack Deleting." 
done

aws --region $REGION cloudformation create-stack --stack-name $STACKNAME --template-body file://orchestrator.json --parameters ParameterKey=KeyName,ParameterValue=default --capabilities CAPABILITY_IAM 

while [ `aws --region $REGION cloudformation describe-stacks --stack-name $STACKNAME --output text --query 'Stacks[*].[StackStatus]'` != "CREATE_COMPLETE" ]
do
  sleep 30
  echo "Stack Building." 
done

aws --region $REGION cloudformation describe-stacks --stack-name $STACKNAME --output text --query 'Stacks[*].Outputs[*].OutputValue'

