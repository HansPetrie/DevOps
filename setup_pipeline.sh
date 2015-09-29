#!/bin/bash

source devops.cnf

sed "s|JENKINS_SERVER|$JenkinsHostname|g" custom_action_type.json > /tmp/custom_action_type.json
sed -i "s|VERSION_STRING|$VersionString|g" /tmp/custom_action_type.json
aws --region us-east-1 codepipeline create-custom-action-type --cli-input-json file:///tmp/custom_action_type.json

sed "s|VERSION_STRING|$VersionString|g" newpipeline.json > /tmp/newpipeline.json
sed -i "s|ROLEARN|$CodePipelineRoleArn|g" /tmp/newpipeline.json
sed -i "s|DEVOPSBUCKET|$DevopsBucketName|g" /tmp/newpipeline.json
sed -i "s|CODEPIPELINENAME|$CodePipelineName|g" /tmp/newpipeline.json

#If the pipeline already exists delete it and re-create it with the updated custom_action_type
aws --region us-east-1 codepipeline get-pipeline --name $CodePipelineName && aws --region us-east-1 codepipeline delete-pipeline --name $CodePipelineName

aws --region us-east-1 codepipeline create-pipeline --cli-input-json file:///tmp/newpipeline.json


sed "s|VERSION_STRING|$VersionString|g" wordpresspipeline.json > /tmp/wordpresspipeline.json
sed -i "s|ROLEARN|$CodePipelineRoleArn|g" /tmp/wordpresspipeline.json
sed -i "s|DEVOPSBUCKET|$DevopsBucketName|g" /tmp/wordpresspipeline.json
sed -i "s|CODEPIPELINENAME|WordPressPipeline|g" /tmp/wordpresspipeline.json

#If the pipeline already exists delete it and re-create it with the updated custom_action_type
aws --region us-east-1 codepipeline get-pipeline --name WordPressPipeline && aws --region us-east-1 codepipeline delete-pipeline --name WordPressPipeline 

aws --region us-east-1 codepipeline create-pipeline --cli-input-json file:///tmp/wordpresspipeline.json

