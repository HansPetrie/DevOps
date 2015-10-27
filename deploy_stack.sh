#!/bin/bash

set -e

FILE=$1
STACKNAME=$2
REGION=$3
PARAMETERS=$4

aws --region $REGION cloudformation create-stack --stack-name $STACKNAME --parameters $PARAMETERS --template-body file://$FILE --capabilities CAPABILITY_IAM 

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
