#!/bin/bash

set -a
source .env
set +a

gcloud artifacts repositories create \
    $ARTIFACT_REPOSITORY_NAME \
    --location=$ARTIFACT_REPOSITORY_LOCATION \
    --repository-format=docker \
    --mode=standard-repository \
    --project=$PROJECT_ID
