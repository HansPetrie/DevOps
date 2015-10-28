#!/bin/bash

set -e

FILE=$1
STACKNAME=$2
REGION=$3
PARAMETERS=$4

echo "Creating Stack from  FILE: $FILE    Stack: $STACKNAME   REGION: $REGION   PARAMETERS: $PARAMETERS"

aws --region $REGION cloudformation describe-stacks --stack-name $STACKNAME --output text --query 'Stacks[*].[StackStatus]' && aws --region $REGION cloudformation delete-stack --stack-name $STACKNAME

while aws --region $REGION cloudformation describe-stacks --stack-name $STACKNAME
do
  sleep 20
  echo "Stack Deleting." 
done


aws --region $REGION cloudformation create-stack --stack-name $STACKNAME --parameters $PARAMETERS --template-body file://$FILE --capabilities CAPABILITY_IAM 

STATUS="UNKNOWN"
while [ "$STATUS" != "CREATE_COMPLETE" ]
do
  STATUS=`aws --region $REGION cloudformation describe-stacks --stack-name $STACKNAME --output text --query 'Stacks[*].[StackStatus]'`
  if [ "$STATUS" == "CREATE_FAILED" ]; then
	exit 1
  fi
  if [ "$STATUS" == "ROLLBACK_COMPLETE" ]; then
        exit 1
  fi
  echo "Stack Status: $STATUS"
  sleep 20 
done

aws --region $REGION cloudformation describe-stacks --stack-name $STACKNAME --output text --query 'Stacks[*].Outputs[*].[OutputKey,OutputValue]'
