#!/bin/bash
set -xe

REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/region)

COMMIT_SHA=$(aws deploy get-deployment --region $REGION --deployment-id $DEPLOYMENT_ID --query "deploymentInfo.revision.gitHubLocation.commitId" --output text)
REPOSITORY=$(aws deploy get-deployment --region $REGION --deployment-id $DEPLOYMENT_ID --query "deploymentInfo.revision.gitHubLocation.repository" --output text)

GITHUB_TOKEN=$(aws ssm get-parameter --region $REGION --name GITHUB_TOKEN --with-decryption --query Parameter.Value --output text)

DB_HOST=$(aws ssm get-parameter --region $REGION --name ${APPLICATION_NAME}_database_host --with-decryption --query Parameter.Value --output text)
DB_NAME=$(aws ssm get-parameter --region $REGION --name ${APPLICATION_NAME}_database_name --with-decryption --query Parameter.Value --output text)
DB_USERNAME=$(aws ssm get-parameter --region $REGION --name ${APPLICATION_NAME}_database_username --with-decryption --query Parameter.Value --output text)
DB_PASSWORD=$(aws ssm get-parameter --region $REGION --name ${APPLICATION_NAME}_database_password --with-decryption --query Parameter.Value --output text)

FRONTEND_TAG=$([ $REPOSITORY == "boanerges-frontend" ] && echo $COMMIT_SHA || echo "latest")
BACKEND_TAG=$([ $REPOSITORY == "boanerges-backend" ] && echo $COMMIT_SHA || echo "latest")

echo $GITHUB_TOKEN | docker login ghcr.io -u lerkasan --password-stdin

cd /home/ubuntu/app

docker compose up -d
