#!/bin/bash

wget -O /var/lib/jenkins/plugins/aws-codepipeline-for-jenkins.hpi https://s3-us-west-2.amazonaws.com/publicrandomstuff/aws-codepipeline-for-jenkins.hpi
service jenkins restart

