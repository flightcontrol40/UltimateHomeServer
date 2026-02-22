#!/usr/bin/env bash

RELEASE_NAME=${1:-media}
NAMESPACE=${2:-media}

echo "The deployment script is only meant to be ran once. If you need to upgrade the deployment, use bin/upgrade.sh instead."
echo "Are you sure you want to continue? (y/n)"
read -r response
if [[ ! ${response,,} =~ ^y(es)?$ ]]; then
    exit 0
fi

helm install "$RELEASE_NAME" ./ -f values.yaml -f secrets.yaml --namespace "$NAMESPACE"
