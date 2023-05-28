#!/bin/bash
set -eu

argo_chart_ver="5.34.5"

# //////////////  Argo configs  //////////////////////////////////////

# helm install my-argo-cd argo/argo-cd --version $argo_chart_ver
# kubectl create namespace argocd

# #apply argo crds - currenty done with tf helm provider
# kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

#apply infra-repo & private key for argo auth on app of apps
kubectl apply -f ./manifests/argo/config-repo.yaml 
kubectl apply -f ./manifests/argo/app-repo.yaml 
# argocd repo add $infra-repo --insecure-ignore-host-key --ssh-private-key-path ~/.ssh/id_rsa_git_main

#apply app of apps
kubectl apply -f ./manifests/argo/app-of-apps.yaml

###

# //////////////  Argo Pass  //////////////////////////////////////

# Patch argo admin pass

# bcrypt(password)=$2a$10$rRyBsGSHK6.uc8fntPwVIuLVHgsAhAX7TcdrqW/RADU0uh7CaChLa
# kubectl -n argocd patch secret argocd-secret -p \
#   '{"stringData": {"admin.password": "$2a$10$rRyBsGSHK6.uc8fntPwVIuLVHgsAhAX7TcdrqW/RADU0uh7CaChLa","admin.passwordMtime": "'$(date +%FT%T%Z)'"}}'

# kubectl patch secret -n argocd argocd-secret \
#   -p '{"stringData": {"admin.password": "'$(htpasswd -bnBC 10 "" newpassword | tr -d ':\n')'"}}'

secret="argocd-initial-admin-secret" # argocd-secret
# Get argo admin pass
argo_pass=`kubectl -n argocd get secret $secret -o jsonpath="{.data.password}" | base64 -d`
# kubectl get secret -n argocd argocd-secret -o json | \
#   jq '.data|to_entries|map({key, value:.value|@base64d})|from_entries'

echo -e "\n argo admin pass is $argo_pass \n"


# argocd login --core
#deploying argo app to argocd ns app will trigger all other infrastructiure in the cluster