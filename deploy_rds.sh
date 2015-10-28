deploy_stack.sh cloudformation/rdsmysql.json RDSProduction us-east-1 "ParameterKey=NetworkStackName,ParameterValue=ProductionNetwork"
aws s3 cp s3://publicrandomstuff/wordpress.sql.zip /tmp
unzip /tmp/wordpress.sql.zip
cat /tmp/wordpress.sql | mysql -u root -ppassword -hrdshostname 
