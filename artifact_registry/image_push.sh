#!/bin/bash

set -a
source .env
set +a

IMAGE_TAG=$ARTIFACT_REPOSITORY_LOCATION-docker.pkg.dev/$PROJECT_ID/$ARTIFACT_REPOSITORY_NAME/wiki:latest

docker pull ghcr.io/requarks/wiki:2
docker tag ghcr.io/requarks/wiki:2 $IMAGE_TAG
docker push $IMAGE_TAG
