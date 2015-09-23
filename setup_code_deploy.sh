#!/bin/bash

source /DevOps/devops.cnf

aws --region us-east-1 deploy create-application --application-name WordPress_App

wget -q -O /tmp https://s3-us-west-2.amazonaws.com/publicrandomstuff/WordPress.zip

unzip /tmp/WordPress.zip

cd /tmp/WordPress

aws --region us-east-1 deploy push --application-name WordPress_App --s3-location s3://$DevopsBucketName/WordPressApp.zip --ignore-hidden-files

aws --region us-east-1 deploy create-deployment-group --application-name WordPress_App --deployment-group-name WordPress_DepGroup --deployment-config-name CodeDeployDefault.OneAtATime --ec2-tag-filters Key=Name,Value=CodeDeployDemo,Type=KEY_AND_VALUE --service-role-arn $CodeDeployRoleArn 

#aws --region us-east-1 deploy create-deployment --application-name WordPress_App --deployment-config-name CodeDeployDefault.OneAtATime --deployment-group-name WordPress_DepGroup --s3-location bucket=$DevopsBucketName,bundleType=zip,key=WordPressApp.zip
