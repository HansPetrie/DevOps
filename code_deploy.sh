#!/bin/bash

aws s3 cp s3://aws-codedeploy-us-east-1/latest/install /tmp --region us-east-1
chmod +x /tmp/install
/tmp/install auto
