#!/bin/bash

source devops.cnf

aws s3 ls s3://$DevOpsBucketName || aws s3 mb s3://$DevOpsBucketName
