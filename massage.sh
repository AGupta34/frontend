API=$(gcloud run services describe frontend --region=$1 --format="value(status.url)" --impersonate-service-account="sa-terraform@sinuous-crow-370906.iam.gserviceaccount.com")
stripped=$(echo ${API/https:\/\//})
sed -i"" -e "s/127.0.0.1:9000/$stripped/" www/js/main.js

