#!/bin/bash
set -eu

# //////////////  VARS  //////////////////////////////////////
release="BookMaker"

# //////////////  HELM Install  //////////////////////////////////////

helm install $release ./config/helm/app_chart/ \ 
  --namespace app --create-namespace
