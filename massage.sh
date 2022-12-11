API=$(gcloud run services describe frontend --region=$1 --format="value(status.url)" --service-account="cloud-run-sa@${PROJECT_ID}.iam.gserviceaccount.com")
stripped=$(echo ${API/https:\/\//})
sed -i"" -e "s/127.0.0.1:9000/$stripped/" www/js/main.js

