#!/bin/bash

if [[ -z "$1" ]]; then
  echo "You have to specify the Microsoft Teams URL"
  echo "Usage: installNotificationService.sh MicrosoftTeamsURL"
  exit 1
fi

LATEST_RELEASE=$(curl -s https://api.github.com/repos/keptn-contrib/notification-service/releases/latest | grep tag_name | cut -d '"' -f 4)

echo "============================================================="
echo "About to install the Notification Service $LATEST_RELEASE for keptn"
echo "============================================================="
read -rsp $'Press ctrl-c to abort. Press any key to continue...\n' -n1 key

## Install Notification Service
git clone --branch release-$LATEST_RELEASE https://github.com/keptn-contrib/notification-service --single-branch
rm -f ./manifests/notification-service.yaml
cp -r ./notification-service/deploy/* ./manifests/notification-service.yaml
rm -rf ./notification-service
cat ./manifests/notification-service.yaml | \
  sed '/name: TEAMS_URL/!b;n;c\ \ \ \ \ \ \ \ \ \ value: "'$1'"' > ./manifests/gen/notification-service.yaml

kubectl apply -f ./manifests/gen/notification-service.yaml
