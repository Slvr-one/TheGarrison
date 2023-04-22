# Kubernetes cluster bootstrap with ansible & kubeadm

the install-all.yml will install a kubernetes 1.17 cluster with kubeadm and flannel.


## components

- kubernetes 1.17
- flannel

## getting started

generate a new cluster join token and insert it in the inventory with

`kubeadm token generate`

or use one for tests only e.g
`sw4xjw.xfar3wciairc2n7o`

Then run the playbook:

`ansible-playbook -i inventories/<example-inventory>/ install-all.yml`

you can give your newly added Nodes the "worker" label with
`kubectl label node <nodeName> node-role.kubernetes.io/worker=worker`
