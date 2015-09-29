#!/bin/bash

source devops.cnf

erb -r './devops.rb' custom_action_type.json > /tmp/custom_action_type.json
aws --region us-east-1 codepipeline create-custom-action-type --cli-input-json file:///tmp/custom_action_type.json

erb -r './devops.rb' newpipeline.json > /tmp/newpipeline.json

#If the pipeline already exists delete it and re-create it with the updated custom_action_type
aws --region us-east-1 codepipeline get-pipeline --name $CodePipelineName && aws --region us-east-1 codepipeline delete-pipeline --name $CodePipelineName
aws --region us-east-1 codepipeline create-pipeline --cli-input-json file:///tmp/newpipeline.json


erb -r './devops.rb' wordpresspipeline.json > /tmp/wordpresspipeline.json

aws --region us-east-1 codepipeline get-pipeline --name WordPressPipeline && aws --region us-east-1 codepipeline delete-pipeline --name WordPressPipeline 
aws --region us-east-1 codepipeline create-pipeline --cli-input-json file:///tmp/wordpresspipeline.json

