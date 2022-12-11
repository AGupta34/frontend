#!/bin/bash
# exit on error
set -e
set -u


PATH=$PATH:/gcloud/bin
gcloud config set auth/impersonate_service_account "sa-terraform@${PROJECT_ID}.iam.gserviceaccount.com"
gcloud projects add-iam-policy-binding "${PROJECT_ID}" --member="serviceAccount:sa-terraform@${PROJECT_ID}.iam.gserviceaccount.com" --role="roles/iam.serviceAccountTokenCreator" --condition=None

API=$(gcloud run services describe frontend --region=$1 --format="value(status.url)")
stripped=$(echo ${API/https:\/\//})
sed -i"" -e "s/127.0.0.1:9000/$stripped/" www/js/main.js

