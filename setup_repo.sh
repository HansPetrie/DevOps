#!/bin/bash

repo_name="default-repo"
repo_description="The DevOps Default Repository"
repo_region="us-east-1"

aws --region $repo_region codecommit get-repository --repository-name $repo_name || aws --region $repo_region codecommit create-repository --repository-name "$repo_name" --repository-description "$repo_description"
