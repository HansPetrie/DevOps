#!/bin/bash

source devops.conf

aws --region $repo_region codecommit get-repository --repository-name $repo_name || aws --region $repo_region codecommit create-repository --repository-name "$repo_name" --repository-description "$repo_description"