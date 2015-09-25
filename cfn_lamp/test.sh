#!/bin/bash

STACKNAME=test$(date +%Y%m%d%H%M%S)

aws --region us-east-1 cloudformation create-stack --stack-name $STACKNAME --template-body file://teststack.json --parameters ParameterKey=DBPassword,ParameterValue=password ParameterKey=DBRootPassword,ParameterValue=password ParameterKey=KeyName,ParameterValue=default ParameterKey=DBUser,ParameterValue=username --capabilities CAPABILITY_IAM 

while [ `aws --region us-east-1 cloudformation describe-stacks --stack-name $STACKNAME --output text --query 'Stacks[*].[StackStatus]'` != "CREATE_COMPLETE" ]
do
  sleep 30
  echo "Stack Building." 
done

aws --region us-east-1 cloudformation describe-stacks --stack-name $STACKNAME --output text --query 'Stacks[*].Outputs[*].OutputValue'

