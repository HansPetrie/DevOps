#!/bin/bash

source devops.cnf

aws --region us-east-1 codepipeline create-custom-action-type --cli-input-json file://rendered_templates/custom_action_type.json

#If the pipeline already exists delete it and re-create it with the updated custom_action_type
aws --region us-east-1 codepipeline get-pipeline --name $CodePipelineName && aws --region us-east-1 codepipeline delete-pipeline --name $CodePipelineName
aws --region us-east-1 codepipeline create-pipeline --cli-input-json file://rendered_templates/newpipeline.json

aws --region us-east-1 codepipeline get-pipeline --name WordPressPipeline && aws --region us-east-1 codepipeline delete-pipeline --name WordPressPipeline 
aws --region us-east-1 codepipeline create-pipeline --cli-input-json file://rendered_templates/wordpresspipeline.json

