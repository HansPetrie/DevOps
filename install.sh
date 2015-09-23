#!/bin/bash

./get_envs.sh
./setup_repo.sh
./setup_git.sh
./jenkins.sh
./jenkins_proxy.sh
./setup_bucket.sh
./setup_pipeline.sh
./code_deploy_agent.sh
./setup_code_deploy.sh
