#!/bin/bash

echo "KEPTN_API_URL:"
KEPTN_API_URL=https://api.keptn.$(kubectl get cm -n keptn keptn-domain -ojsonpath={.data.app_domain})
echo $KEPTN_API_URL
echo ""
echo "KEPTN_API_TOKEN:"
KEPTN_API_TOKEN=$(kubectl get secret keptn-api-token -n keptn -ojsonpath={.data.keptn-api-token} | base64 --decode)
echo $KEPTN_API_TOKEN
echo ""
keptn auth --endpoint=$KEPTN_API_URL --api-token=$KEPTN_API_TOKEN
