#!/bin/bash
set -euo pipefail

--- terraform
kubectl apply -f vpc.yaml

kubectl apply -f subnet.yaml

kubectl apply -f sg.yaml


--- ansible

ansible-playbook playbook.yml -i ../terraform/inventory.ini --user <ssh_user> --key-file <path_to_ssh_key>

sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# Set up Kubernetes configuration for regular user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install Flannel networking plugin
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k


# Join worker nodes to cluster
kubeadm token create --print-join-command > join.sh
chmod +x join.sh

# Run join.sh on worker nodes
ansible-playbook join.yml -i ../terraform/inventory.ini --user <ssh_user> --key-file <path_to_ssh_key>

---

/etc/ansible/ansible.cfg -->

[defaults]
inventory = /etc/myhosts.txt
host_key_checking=False
command_warnings=false


ansible  all  --host-lists       ----> will give list of hosts

ansibel  all  -m  ping           ----> will check wether hosts is pingable or not 