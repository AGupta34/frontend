#!/bin/bash
# exit on error
set -e
set -u


PATH=$PATH:/gcloud/bin
gcloud config set auth/impersonate_service_account "${GOOGLE_IMPERSONATE_SERVICE_ACCOUNT}"
gcloud config set project "${PROJECT_ID}"
API=$(gcloud run services describe frontend --region=$1 --format="value(status.url)" --impersonate-service-account="sa-terraform@${PROJECT_ID}.iam.gserviceaccount.com")
stripped=$(echo ${API/https:\/\//})
sed -i"" -e "s/127.0.0.1:9000/$stripped/" www/js/main.js

