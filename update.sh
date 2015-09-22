#!/bin/bash

aws s3 cp orchestrator.json s3://publicrandomstuff --acl public-read
cd ..
zip -r DevOps.zip DevOps
aws s3 cp DevOps.zip s3://publicrandomstuff --acl public-read
