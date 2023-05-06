#!/bin/bash
set -eu

AWS_ACCOUNT="514095112279"
AWS_REGION="eu-central-1"
EMAIL="dviross@outlook.com"
SECRET_NAME=${AWS_REGION}-ecr-registry #regcred


TOKEN=`aws ecr --region=$AWS_REGION get-authorization-token --output text --query authorizationData[].authorizationToken | base64 -d | cut -d: -f2`

# Create or repleace registry secret

kubectl delete secret --ignore-not-found $SECRET_NAME
 
kubectl create secret docker-registry $SECRET_NAME \
    --docker-server=${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com \
    --docker-email="${EMAIL}" \
    --docker-password="${TOKEN}" \
    --docker-username=AWS \
    --docker-password=$(aws ecr get-login-password) 


# k get secrets regcred -o yaml > regcred.yaml


# NOTES:

# 1. Get your 'admin' user password by running:
kubectl exec --namespace default -it svc/myjenkins -c jenkins -- /bin/cat /run/secrets/chart-admin-password && echo
# 2. Get the Jenkins URL to visit by running these commands in the same shell:
#   NOTE: It may take a few minutes for the LoadBalancer IP to be available.
# You can watch the status of by running 
kubectl get svc --namespace default -w myjenkins

export SERVICE_IP=$(kubectl get svc --namespace default myjenkins --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")
echo http://$SERVICE_IP:8080/login

# 3. Login with the password from step 1 and the username: admin
# 4. Configure security realm and authorization strategy
# 5. Use Jenkins Configuration as Code by specifying configScripts in your values.yaml file, see documentation: http:///configuration-as-code and examples: https://github.com/jenkinsci/configuration-as-code-plugin/tree/master/demos
