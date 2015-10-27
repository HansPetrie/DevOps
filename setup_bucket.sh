#!/bin/bash

source devops.cnf

cd cfn_lamp
zip -r /tmp/test.zip *

aws --region us-east-1 s3 ls s3://$DevopsBucketName || aws s3 mb s3://$DevopsBucketName
aws --region us-east-1 s3api put-bucket-versioning --bucket $DevopsBucketName --versioning-configuration Status=Enabled
aws --region us-east-1 s3 cp /tmp/test.zip s3://$DevopsBucketName
