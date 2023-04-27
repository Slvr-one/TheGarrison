#!/bin/bash
set -euo pipefail




Create an AWS account and configure your AWS credentials.

Install Terraform and Ansible on your local machine.

Create a Terraform file to provision the EC2 instances. In this file, you can define the EC2 instance type, region, subnet, security group, and other parameters. You can also specify the number of instances you want to create.

Initialize and apply the Terraform file to create the EC2 instances.

Once the EC2 instances are created, you can use Ansible to install Kubernetes on them. You can use Ansible playbooks to automate the Kubernetes installation process.

The Ansible playbook can include tasks to install the Kubernetes components such as kubeadm, kubelet, kubectl, and others. You can also configure the Kubernetes network and create a Kubernetes cluster.

Run the Ansible playbook on the EC2 instances to install Kubernetes.

Once the Kubernetes installation is complete, you can access the Kubernetes cluster and deploy your applications.




# Create a file called install-kubernetes.yaml and paste the following code:
---
- name: Install Kubernetes
  hosts: all
  become: true
  tasks:
    - name: Disable swap
      command: swapoff -a
    - name: Add Kubernetes apt key
      apt_key:
        url: https://packages.cloud.google.com/apt/doc/apt-key.gpg
        state: present
    - name: Add Kubernetes apt repository
      apt_repository:
        repo: deb http://apt.kubernetes.io/ kubernetes-xenial main
        state: present
    - name: Install Kubernetes packages
      apt:
        name: "{{ item }}"
        state: present
        update_cache: yes
      with_items:
        - kubelet
        - kubeadm
        - kubectl
    - name: Initialize Kubernetes cluster
      command: kubeadm init --pod-network-cidr=10.244.0.0/16
      register: kubeadm_output
      when: inventory_hostname == groups['kube-master'][0]
    - name: Configure kubectl
      copy:
        content: "{{ kubeadm_output.stdout_lines[-3] }}"
        dest: $HOME/.kube/config
        mode: '0600'
      when: inventory_hostname == groups['kube-master'][0]
    - name: Install Flannel network plugin
      command: kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml


# this playbook:

The hosts: all line specifies that the playbook should run on all hosts.
The become: true line indicates that the tasks should run with root privileges.
The Disable swap task disables the swap memory on the host machines. Kubernetes requires swap memory to be disabled.
The Add Kubernetes apt key task adds the Kubernetes apt key to the host machines.
The Add Kubernetes apt repository task adds the Kubernetes apt repository to the host machines.
The Install Kubernetes packages task installs the Kubernetes packages (kubelet, kubeadm, and kubectl) on the host machines.
The Initialize Kubernetes cluster task initializes the Kubernetes cluster using kubeadm init. The --pod-network-cidr option specifies the IP address range for the pod network. The register statement stores the output of the command in a variable named kubeadm_output.
The Configure kubectl task copies the Kubernetes configuration file to the home directory of the current user. This is required to use kubectl to interact with the Kubernetes cluster.
The Install Flannel network plugin task installs the Flannel network plugin on the Kubernetes cluster. This is required to enable pod-to-pod communication.
Save the file and run the playbook using the following command:

ansible-playbook -i <path-to-inventory-file> install-kubernetes.yaml
