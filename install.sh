#!/bin/bash

./get_envs.sh
./render_templates.sh
./setup_repo.sh
./setup_git.sh
./jenkins.sh
./jenkins_proxy.sh
./configure_jenkins.sh
./rundeck.sh
./setup_code_deploy.sh
./setup_bucket.sh
./setup_pipeline.sh
./code_deploy_agent.sh
