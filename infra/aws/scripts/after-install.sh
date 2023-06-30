#!/bin/bash
set -xe

REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/region)

GITHUB_TOKEN=$(aws ssm get-parameter --region $REGION --name GITHUB_TOKEN --with-decryption --query Parameter.Value --output text)
COMMIT_SHA=$(aws deploy get-deployment --deployment-id $DEPLOYMENT_ID --query "deploymentInfo.revision.gitHubLocation.commitId" --output text)
REPOSITORY=$(aws deploy get-deployment --deployment-id $DEPLOYMENT_ID --query "deploymentInfo.revision.gitHubLocation.repository" --output text)

FRONTEND_TAG=$([ $REPOSITORY == "boanerges-frontend" ] && echo $COMMIT_SHA || echo "latest")
BACKEND_TAG=$([ $REPOSITORY == "boanerges-backend" ] && echo $COMMIT_SHA || echo "latest")

echo $GITHUB_TOKEN | docker login ghcr.io -u lerkasan --password-stdin

cd /home/ubuntu/app

docker compose pull