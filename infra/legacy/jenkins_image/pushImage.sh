#!/bin/bash
set -eux

name="jenkins"
tag=$1

id="839821061981"
region="eu-central-1" #frankfurt

repo="$id.dkr.ecr.$region.amazonaws.com"

#install awscli(.sh)

aws ecr get-login-password \
    --region $region | \
    docker login --username AWS \
    --password-stdin $repo

docker build -f Dockerfile.jenkins -t $name .

docker tag $name:latest $repo/$name:$tag

docker push $repo/$name:$tag