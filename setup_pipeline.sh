HOSTNAME=$(curl -s 169.254.169.254/latest/meta-data/public-hostname/)
VERSION=$(date +%m%d%H%M)

# Sleep allows Jenkins time to start up and extract itself
sleep 30 
wget -O /var/lib/jenkins/plugins/aws-codepipeline-for-jenkins.hpi https://s3-us-west-2.amazonaws.com/publicrandomstuff/aws-codepipeline-for-jenkins.hpi
mkdir -p /var/lib/jenkins/jobs/MyDemoProject

sed "s|VERSION_STRING|$VERSION|g" config.xml > /tmp/config.xml

cp /tmp/config.xml /var/lib/jenkins/jobs/MyDemoProject
chown -R jenkins:jenkins /var/lib/jenkins/jobs/MyDemoProject
service jenkins restart


sed "s|JENKINS_SERVER|$HOSTNAME|g" custom_action_type.json > /tmp/custom_action_type.json
sed -i "s|VERSION_STRING|$VERSION|g" /tmp/custom_action_type.json
aws --region us-east-1 codepipeline create-custom-action-type --cli-input-json file:///tmp/custom_action_type.json

sed "s|VERSION_STRING|$VERSION|g" newpipeline.json > /tmp/newpipeline.json
aws --region us-east-1 codepipeline create-pipeline --cli-input-json file:///tmp/newpipeline.json
