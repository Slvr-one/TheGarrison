#!/bin/bash
set -eux

ps -ef | grep etcd

--
kubectl cluster-info

kubectl config view --minify --flatten --context=kind-terraform-learn

#kubectl get cs -- Warning: v1 ComponentStatus is deprecated in v1.19+
kubectl get --raw='/readyz?verbose' # curl -k <https://localhost:6443>/livez?verbose

--
kubectl get service -A -o json | jq '.items[] | select (.spec.type=="ClusterIP")' | jq '.metadata.name'
--
kubectl delete services $(kubectl get services --all-namespaces \
-o jsonpath='{range .items[?(@.spec.type=="LoadBalancer")]}{.metadata.name}{" -n "}{.metadata.namespace}{"\n"}{end}')
--
# Update a single-container pod's image version (tag) to v4
kubectl get pod mypod -o yaml | sed 's/\(image: myimage\):.*$/\1:v4/' | kubectl replace -f -
--
certs:
--
openssl x509 -in /etc/kubernetes/pki/<cert> -text -noout
# https://github.com/mmumshad/kubernetes-the-hard-way/tree/master/tools

--
brew tap mongodb/brew
------

# Install CFSSL
# The cfssl and cfssljson command line utilities will be used to provision a PKI Infrastructure and generate TLS certificates.

# Download and install cfssl and cfssljson:

brew install cfssl
# -/-
wget -q --show-progress --https-only --timestamping \
  https://storage.googleapis.com/kubernetes-the-hard-way/cfssl/1.4.1/linux/cfssl \
  https://storage.googleapis.com/kubernetes-the-hard-way/cfssl/1.4.1/linux/cfssljson

chmod +x cfssl cfssljson

sudo mv cfssl cfssljson /usr/local/bin/

# cfssl version && cfssljson --version

---

# Install kubectl
# The kubectl command line utility is used to interact with the Kubernetes API Server. Download and install kubectl from the official release binaries:

wget https://storage.googleapis.com/kubernetes-release/release/v1.21.0/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# kubectl version --client
