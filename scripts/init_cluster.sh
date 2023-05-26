#!/bin/bash
set -eux

# //////////////  VARS  //////////////////////////////////////

name="local_dev"
region=`aws configure get region`
aws_account_id="514095112279"

release="dvir"
# infra-repo="git@github.com:Slvr-one/porfolio-config.git"

echo "cluster name will be $name"

# //////////////  INFRA  //////////////////////////////////////

# aws configure 

#to provision eks cluster with tf
pushd ../infra/
terraform init
terraform apply -auto-approve
popd

# //////////////  CONFIG  //////////////////////////////////////

aws eks --region $region update-kubeconfig --name $name 
# kubectl config set-context $name

# Applies the cert-manager CRDs:
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.10.1/cert-manager.crds.yaml

# Apply ArgoCD configuration files:
./config/argo/setup.sh

pushd infra/argo
kubectl -n argocd apply -f app-of-app.yaml
popd

# Configure, port-forward services:
./services.sh

# //////////////  EXTRA  //////////////////////////////////////

exit 0
# Retrieves the security group ID of the EKS cluster:
sg_id=`aws eks describe-cluster --name $name --query cluster.resourcesVpcConfig.clusterSecurityGroupId`

# Set the context outputted by Terraform.
context=`tf output -json cluster_endpoint | jq -r .`

# kubectl logs -f -n monitoring grafana-pod-name

# Retrieves the admin password for Grafana.
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
# echo "$(kubectl get secret grafana-admin --namespace monitoring -o jsonpath="{.data.GF_SECURITY_ADMIN_PASSWORD}" | base64 --decode)"


