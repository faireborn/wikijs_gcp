#!/bin/bash

set -a
source .env
set +a

IMAGE_TAG=$ARTIFACT_REPOSITORY_LOCATION-docker.pkg.dev/$PROJECT_ID/$ARTIFACT_REPOSITORY_NAME/wikijs:latest

docker build -t $IMAGE_TAG .
docker push $IMAGE_TAG
