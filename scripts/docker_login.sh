#!/usr/bin/env bash
set -euo pipefail

# //////////////  VARS  //////////////////////////////////////

NAMESPACE=$1

AWS_ACCOUNT="839821061981"
AWS_REGION=`aws configure get region`
EMAIL="dviross@outlook.com"
SECRET_NAME=${AWS_REGION}-ecr-registry # regcred

TOKEN=`aws ecr --region=$AWS_REGION get-authorization-token \
  --output text --query authorizationData[].authorizationToken | base64 -d | cut -d: -f2`

# //////////////  HELM Install Mirrors //////////////////////////////////////
# https://github.com/ktsstudio/mirrors

# # install mirrors project to the cluster:
# helm repo add kts https://charts.kts.studio
# helm repo update

helm upgrade --install mirrors kts/mirrors

# //////////////  CREATE or REPLACE registry secret //////////////////////////////////////

kubectl delete secret --ignore-not-found $SECRET_NAME
 
kubectl -n $NAMESPACE create secret docker-registry $SECRET_NAME \
    --docker-server=${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com \
    --docker-email="${EMAIL}" \
    --docker-password="${TOKEN}" \
    --docker-username=AWS \
    --docker-password=$(aws ecr get-login-password) 

# kubectl get secrets regcred -o yaml > regcred.yaml