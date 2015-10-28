./deploy_stack.sh cloudformation/opsworkswordpress.json opsworkswordpress us-east-1 "ParameterKey=NetworkStackName,ParameterValue=networkstage ParameterKey=DBHostname,ParameterValue=rr1ulpp3ueskrv0.c8inuxom6pg8.us-east-1.rds.amazonaws.com --on-failure DO_NOTHING"

