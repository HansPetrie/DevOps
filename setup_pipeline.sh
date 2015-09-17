aws --region us-east-1 codepipeline create-custom-action-type --cli-input-json file://custom_action_type.json
aws --region us-east-1 codepipeline create-pipeline --cli-input-json file://newpipeline.json
