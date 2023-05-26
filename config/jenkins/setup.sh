#!/bin/bash
set -eu

# //////////////  VARS  //////////////////////////////////////

AWS_ACCOUNT="514095112279"
AWS_REGION="eu-central-1"
EMAIL="dviross@outlook.com"
SECRET_NAME=${AWS_REGION}-ecr-registry #regcred

TOKEN=`aws ecr --region=$AWS_REGION get-authorization-token --output text --query authorizationData[].authorizationToken | base64 -d | cut -d: -f2`

# //////////////  CREATE or REPLACE registry secret //////////////////////////////////////

kubectl delete secret --ignore-not-found $SECRET_NAME
 
kubectl create secret docker-registry $SECRET_NAME \
    --docker-server=${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com \
    --docker-email="${EMAIL}" \
    --docker-password="${TOKEN}" \
    --docker-username=AWS \
    --docker-password=$(aws ecr get-login-password) 

# kubectl get secrets regcred -o yaml > regcred.yaml

# Get 'admin' user password by running:
kubectl exec --namespace default -it svc/myjenkins -c jenkins -- /bin/cat /run/secrets/chart-admin-password && echo
# Default username: admin

# It may take a few minutes for the LoadBalancer IP to be available:
kubectl get svc --namespace default -w myjenkins

export SERVICE_IP=$(kubectl get svc --namespace default myjenkins --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")
echo http://$SERVICE_IP:8080/login

# //////////////  NOTES //////////////////////////////////////

# Configure security realm and authorization strategy
# Use Jenkins Configuration as Code by specifying configScripts in your values.yaml file.
# docs: http:///configuration-as-code 
# examples: https://github.com/jenkinsci/configuration-as-code-plugin/tree/master/demos
