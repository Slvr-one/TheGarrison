#!/bin/bash
set -eux

name=$1 #"victor-12"
region="eu-central-1"
release="dvir"
aws_account_id="514095112279"
infra-repo="git@github.com:Slvr-one/porfolio-config.git"

echo "cluster name will is $1"

aws configure #check for correct config

#to provision eks cluster with tf
pushd infra/tf/
terraform init
terraform apply -auto-approve

popd

aws eks --region $region update-kubeconfig --name $name # / # kubectl config set-context $name

# Retrieves the security group ID of the EKS cluster and sets the context outputted by Terraform.
sg_id=`aws eks describe-cluster --name $name --query cluster.resourcesVpcConfig.clusterSecurityGroupId`

context=`tf output -json cluster_endpoint | jq -r .`

# Applies the cert-manager CRDs and ArgoCD configuration files
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.10.1/cert-manager.crds.yaml

./scripts/argo-config.sh

pushd infra/argo
kubectl -n argocd apply -f app-of-app.yaml
popd

./scripts/services.sh

# kubect logs -f -n monitoring grafana-pod-name

# Retrieves the admin password for Grafana.
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
echo "$(kubectl get secret grafana-admin --namespace monitoring -o jsonpath="{.data.GF_SECURITY_ADMIN_PASSWORD}" | base64 --decode)"


# Update a single-container pod's image version (tag) to v4
kubectl get pod mypod -o yaml | sed 's/\(image: myimage\):.*$/\1:v4/' | kubectl replace -f -

# terraform output # -json


