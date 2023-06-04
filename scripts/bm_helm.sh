#!/usr/bin/env bash
set -eu

# //////////////  VARS  //////////////////////////////////////
release="bm-app"
ns="app"

# //////////////  HELM Install  //////////////////////////////////////

# kubectl create namespace $ns
./scripts/docker_login $ns

helm -n $ns upgrade --install $release ./config/helm/app_chart/ # --create-namespace 

# kubectl -n $ns port-forward svc/dvir-bm-app 8077:80
# minikube addons enable ingress