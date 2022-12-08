#!/bin/bash
# exit on error
set -e
set -u


PATH=$PATH:/gcloud/bin
gcloud config set auth/impersonate_service_account "${GOOGLE_IMPERSONATE_SERVICE_ACCOUNT}"
gcloud config set project "${PROJECT_ID}"



TAG_FORMATTED=$(echo "${BRANCH_TAG/./"-"}")
TAG_FORMATTED=$(echo "${TAG_FORMATTED/./"-"}")

echo "Deploying '$1' image ${IMAGE_NAME}, under tag ${TAG_FORMATTED} using SA ${GOOGLE_IMPERSONATE_SERVICE_ACCOUNT}"
gcloud run deploy "$1" \
        --image="${IMAGE_NAME}"  \
        --region=northamerica-northeast1 \
        --allow-unauthenticated \
        --service-account="rapids-api-cloud-run-sa@${PROJECT_ID}.iam.gserviceaccount.com"  \
        --tag="${TAG_FORMATTED}" \
        --set-env-vars=PROJECT_ID=$PROJECT_ID


