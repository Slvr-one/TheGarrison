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

  amis = var.amis
  zone = var.zone
  HA   = var.HA

  elb_name     = var.elb_name
  keypair_name = var.keypair_name

  vpc_cidr            = var.vpc_cidr
  control_cidr        = var.control_cidr
  kubernetes_pod_cidr = var.kubernetes_pod_cidr

  worker_instance_type     = var.worker_instance_type
  etcd_instance_type       = var.etcd_instance_type
  controller_instance_type = var.controller_instance_type

  k8s_iam_profile     = module.iam.k8s_iam_profile
  k8s_subnet_id       = module.network.k-subnet.id
  control-plane_sg_id = module.network.api-sg.id
  k8s_sg_id           = module.network.k-sg.id

  ansibleFilter = var.ansibleFilter

  # node_config = var.node_config
  region = var.region
  tags   = var.tags
}


module "iam" {
  source = "./modules/iam"

  tags = var.tags
}

module "ansible" {
  source = "./modules/ansible"

  HA = var.HA
  controllers = module.cluster.control-plane_nodes
  workers = module.cluster.worker_nodes
}
# module "s3_bucket" {
#   source = "terraform-aws-modules/s3-bucket/aws"

#   bucket = "dvir-tf-state"
#   acl    = "private"

#   versioning = {
#     enabled = true
#   }

# }

# module "dynamodb_table" {
#   source   = "terraform-aws-modules/dynamodb-table/aws"

#   name     = "dvir-tf-state"
#   hash_key = "id"

#   attributes = [
#     {
#       name = "id"
#       type = "N"
#     }
#   ]

#   tags = {
#     Terraform   = "true"
#     Environment = "staging"
#   }
# }