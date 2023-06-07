#!/usr/bin/env bash
set -eux

# //////////////  VARS  //////////////////////////////////////

name="local_dev"
region=`aws configure get region`
aws_account_id="514095112279"

release="dvir"

# //////////////  INFRA  //////////////////////////////////////
echo "cluster name will be $name"

# aws configure 

# Provision k8s cluster with tf
pushd infra/

terraform init
terraform apply -auto-approve

popd

# //////////////  CONFIG  //////////////////////////////////////

# Set kubeconfig:
# gcloud container clusters get-credentials $(terraform output -raw kubernetes_cluster_name) --region $(terraform output -raw region)
# aws eks --region $region update-kubeconfig --name $name 
kubectl config set-context $name

# K8s Dashbord - https://developer.hashicorp.com/terraform/tutorials/kubernetes/gke#deploy-and-access-kubernetes-dashboard
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml

# Apply  cert-manager CRDs:
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.10.1/cert-manager.crds.yaml

# Apply ArgoCD configuration files:
./config/argo/setup.sh

kubectl -n argocd apply -f infra/manifests/argo/

# Configure, port-forward services:
./scripts/services.sh

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


