# variable "node_config" {
#   description = "The total nodes configuration, List of Objects/Dictionary"
#   default     = [{}]
# }

variable "region" {
  description = "AWS region to deploy to"
  type        = string
}

variable "tags" {
  description = "general tags; Owner, exp_date, bootcamp"
  type        = map(any)
}

variable "control-plane_sg_id" {
  description = "controllers security group"
}

variable "k8s_sg_id" {
  description = "cluster security group"
}

variable "k8s_subnet_id" {
  description = "subnet id of nodes"
}

variable "k8s_iam_profile" {
  description = "iam profile for controller nodes"
}

variable "zone" {
  description = "availability zone"
}

variable "vpc_cidr" {
  description = "vpc cidr range"
}

variable "control_cidr" {
  description = "CIDR for maintenance: inbound traffic will be allowed from this IPs"
}

variable "elb_name" {
  description = "Name of the ELB for Kubernetes API"
}

variable "ansibleFilter" {
  description = "`ansibleFilter` tag value added to all instances, to enable instance filtering in Ansible dynamic inventory"
}

variable "kubernetes_pod_cidr" {
  description = "cidr range for pods ip adds"
}

variable "amis" {
  description = "Default AMIs to use for nodes depending on the region"
  type        = map(any)
}

variable "etcd_instance_type" {
}

variable "controller_instance_type" {
}

variable "worker_instance_type" {
}

variable "keypair_name" {
  description = "Name of the KeyPair used for all nodes"
}
