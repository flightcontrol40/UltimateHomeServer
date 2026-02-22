#!/usr/bin/env bash

RELEASE_NAME=${1:-media}
NAMESPACE=${2:-media}

helm upgrade -f values.yaml -f secrets.yaml  "$RELEASE_NAME" . --namespace "$NAMESPACE"
