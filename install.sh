#!/bin/bash

./setup_repo.sh
./setup_git.sh
./jenkins.sh
./jenkins_proxy.sh
./jenkins_config.sh
./setup_pipeline.sh
