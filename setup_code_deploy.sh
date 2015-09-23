#!/bin/bash

source /DevOps/devops.cnf

aws --region us-east-1 deploy create-application --application-name wordpress_app

wget -q -O /tmp/wordpress.zip https://s3-us-west-2.amazonaws.com/publicrandomstuff/wordpress.zip

unzip -q /tmp/wordpress.zip -d /tmp 

cd /tmp/wordpress

aws --region us-east-1 deploy push --application-name wordpress_app --s3-location s3://$DevopsBucketName/wordpressapp.zip --ignore-hidden-files

aws --region us-east-1 deploy list-deployment-groups --application-name wordpress_app && aws --region us-east-1 deploy delete-deployment-group --application-name wordpress_app --deployment-group-name wordpress_depgroup

aws --region us-east-1 deploy create-deployment-group --application-name wordpress_app --deployment-group-name wordpress_depgroup --deployment-config-name CodeDeployDefault.OneAtATime --ec2-tag-filters Key=Name,Value=CodeDeployDemo,Type=KEY_AND_VALUE --service-role-arn $CodeDeployRoleArn 

#aws --region us-east-1 deploy create-deployment --application-name wordpress_app --deployment-config-name CodeDeployDefault.OneAtATime --deployment-group-name wordpress_depgroup --s3-location bucket=$DevopsBucketName,bundleType=zip,key=wordpressapp.zip
