#!/bin/bash
set -eu

# //////////////  VARS  //////////////////////////////////////
release="BookMaker"

# //////////////  HELM Install  //////////////////////////////////////

helm install $release ./helm-chart/go-k8s/ \ 
  --namespace go-k8s --create-namespace
