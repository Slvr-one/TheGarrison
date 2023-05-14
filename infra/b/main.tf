# VPC for EKS
module "vpc_for_eks" {
  source = "./modules/vpc"

  eks_cluster_name = var.cluster_name
  vpc_tag_name     = "${var.cluster_name}-vpc"
  region           = var.region
  tags             = var.tags
}

# EKS Cluster
module "eks" { //eks_cluster_and_worker_nodes
  source = "./modules/eks"

  # Cluster
  eks_cluster_name       = var.cluster_name
  vpc_id                 = module.vpc_for_eks.vpc_id
  cluster_sg_name        = "${var.cluster_name}-cluster-sg"
  nodes_sg_name          = "${var.cluster_name}-node-sg"
  eks_cluster_subnet_ids = flatten([module.vpc_for_eks.public_subnet_ids, module.vpc_for_eks.private_subnet_ids])

  # Node group configuration (including autoscaling configurations)
  pvt_desired_size = 3
  pvt_max_size     = 8
  pvt_min_size     = 2

  pblc_desired_size = 1
  pblc_max_size     = 2
  pblc_min_size     = 1

  endpoint_private_access = true
  endpoint_public_access  = true

  node_group_name    = "${var.cluster_name}-node-group"
  private_subnet_ids = module.vpc_for_eks.private_subnet_ids
  public_subnet_ids  = module.vpc_for_eks.public_subnet_ids
}

# module "lb_role" {
#   source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

#   role_name = "${var.env_name}_eks_lb"
#   attach_load_balancer_controller_policy = true

#   oidc_providers = {
#     main = {
#       provider_arn               = module.eks.oidc_issuer
#       namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
#     }
#   }
# }

# #cluster & nodes iam roles
# module "iam" {
#   source = "./modules/iam"

#   fingerprint = module.tls.cert_fingerprint
#   oidc_issuer = module.eks.oidc_issuer
# }

# deploy argocd helm chart in cluster
# module "helm" {
#   source     = "./modules/helm"
#   node_group = module.eks.main_node_group #public_node_group

#   depends_on = [
#     module.vpc_for_eks
#   ]
# }

# # localhost registry with password protection
#   registry {
#     url = "oci://localhost:5000"
#     username = "username"
#     password = "password"
#   }

#   # private registry
#   registry {
#     url = "oci://private.registry"
#     username = "username"
#     password = "password"
#   }

#apply argo app manifest to cluster & start monitoring cluster, infra from argo-config repo
