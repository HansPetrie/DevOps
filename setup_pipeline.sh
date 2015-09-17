HOSTNAME=$(curl -s 169.254.169.254/latest/meta-data/public-hostname/)
echo $HOSTNAME
VERSION=$(date +%y%m%d)
echo $VERSION

sed "s|JENKINS_SERVER|$HOSTNAME|g" custom_action_type.json > /tmp/custom_action_type.json
sed -i "s|VERSION_STRING|$VERSION|g" /tmp/custom_action_type.json
aws --region us-east-1 codepipeline create-custom-action-type --cli-input-json file:///tmp/custom_action_type.json

sed "s|VERSION_STRING|$VERSION|g" newpipeline.json > /tmp/newpipeline.json
aws --region us-east-1 codepipeline create-pipeline --cli-input-json file:///tmp/newpipeline.json
