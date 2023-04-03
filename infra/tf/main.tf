# network for k8s:
module "network" {
  source = "./modules/network"

  control_cidr       = var.control_cidr
  keypair_public_key = var.keypair_public_key
  keypair_name       = var.keypair_name

  # k8s_cluster_name = var.cluster_name
  # vpc_tag_name     = "${var.cluster_name}-vpc"
  region = var.region
  tags   = var.tags
}

# bootstrap k8s cluster:
module "cluster" {
  source = "./modules/cluster"

  control_cidr = var.control_cidr
  keypair_name        = var.keypair_name
  amis = var.amis
  zone = var.zone
  elb_name = var.elb_name

  ansibleFilter = var.ansibleFilter
  kubernetes_pod_cidr = var.kubernetes_pod_cidr
  vpc_cidr = var.vpc_cidr
  
  worker_instance_type = var.worker_instance_type
  etcd_instance_type = var.etcd_instance_type
  controller_instance_type = var.controller_instance_type

  k8s_iam_profile     = module.iam.k8s_iam_profile
  k8s_subnet_id       = module.network.k-subnet.id
  control-plane_sg_id = module.network.api-sg.id
  k8s_sg_id           = module.network.k-sg.id

  # node_config = var.node_config
  region = var.region
  tags   = var.tags
}


module "iam" {
  source = "./modules/iam"

  tags = var.tags
}