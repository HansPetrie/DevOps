#!/bin/bash

STACKNAME=ProductionNetwork
REGION="us-east-1"

aws --region $REGION cloudformation create-stack --stack-name $STACKNAME --parameters ParameterKey=NetworkType,ParameterValue="Stage" --template-body file://teststack.json --capabilities CAPABILITY_IAM 

STATUS="UNKNOWN"
while [ "$STATUS" != "CREATE_COMPLETE" ]
do
  STATUS=`aws --region $REGION cloudformation describe-stacks --stack-name $STACKNAME --output text --query 'Stacks[*].[StackStatus]'`
  if [ "$STATUS" == "CREATE_FAILED" ]; then
	exit 1
  fi
  echo "Stack Status: $STATUS"
  sleep 10 
done

aws --region $REGION cloudformation describe-stacks --stack-name $STACKNAME --output text --query 'Stacks[*].Outputs[*].[OutputKey,OutputValue]'
