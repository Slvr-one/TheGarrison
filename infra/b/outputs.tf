output "cluster_name" {
  value = module.eks.cluster.name
}

output "cluster_endpoint" {
  value = module.eks.host
}

output "cluster_security_group_id" {
  value = module.eks.main_node_group.id
}

output "public_node_group_id" {
  value = module.eks.public_node_group.id
}