#!/bin/bash

LATEST_RELEASE=$(curl -s https://api.github.com/repos/keptn-contrib/dynatrace-sli-service/releases/latest | grep tag_name | cut -d '"' -f 4)

echo "============================================================="
echo "About to install the Dynatrace SLI Service $LATEST_RELEASE for keptn"
echo "============================================================="
read -rsp $'Press ctrl-c to abort. Press any key to continue...\n' -n1 key

## Install Dynatrace SLI Service
git clone --branch release-$LATEST_RELEASE https://github.com/keptn-contrib/dynatrace-sli-service --single-branch
cp -r ./dynatrace-sli-service/deploy/* ./manifests/gen/dynatrace-sli-service.yaml
rm -rf ./dynatrace-sli-service/
kubectl apply -f ./manifests/gen/dynatrace-sli-service.yaml
