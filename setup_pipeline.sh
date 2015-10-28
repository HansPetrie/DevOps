#!/bin/bash

source devops.cnf

for d in $(aws --region us-east-1 codepipeline list-action-types --action-owner-filter Custom --query actionTypes[*].id.[provider,version] --output text | grep Jenkins | awk '{print $2}')
do
  echo "Delete custom action type Custom Build Jenkins $d"
  aws --region us-east-1 codepipeline delete-custom-action-type --category Build --provider Jenkins --action-version $d
done

aws --region us-east-1 codepipeline create-custom-action-type --cli-input-json file://rendered_templates/custom_action_type.json

#If the pipeline already exists delete it and re-create it with the updated custom_action_type
aws --region us-east-1 codepipeline get-pipeline --name $CodePipelineName && aws --region us-east-1 codepipeline delete-pipeline --name $CodePipelineName
aws --region us-east-1 codepipeline create-pipeline --cli-input-json file://rendered_templates/newpipeline.json
