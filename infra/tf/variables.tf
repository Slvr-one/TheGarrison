variable "profile" {
  description = "AWS profile"
  type        = string
}

variable "region" {
  description = "AWS region to deploy to"
  type        = string
}

variable "tags" {
  description = "general tags; Owner, exp_date, bootcamp"
  type        = map(any)
}

variable "cluster_name" {
  description = "dynamic cluster name"
  type        = string
}

variable "elb_name" {
  description = "Name of the ELB for Kubernetes API"
}

variable "k8s_cluster_dns" {
}

variable "amis" {
  description = "Default AMIs to use for nodes depending on the region"
  type        = map(any)
}

variable "zone" {
  description = "availability zone"
}

variable "instance_user" {
}

variable "keypair_name" {
  description = "Name of the KeyPair used for all nodes"
}

variable "keypair_public_key" {
  description = "Public Key of the default keypair"
}


variable "control_cidr" {
  description = "CIDR for maintenance: inbound traffic will be allowed from this IPs"
}

variable "vpc_cidr" {
  description = "vpc cidr range"
}

variable "ansibleFilter" {
  description = "`ansibleFilter` tag value added to all instances, to enable instance filtering in Ansible dynamic inventory"
}

variable "kubernetes_pod_cidr" {
  description = "cidr range for pods ip adds"
}

variable "etcd_instance_type" {
}

variable "controller_instance_type" {
}

variable "worker_instance_type" {
}



# variable "node_config" {
#   description = "The total nodes configuration, List of Objects/Dictionary"
# }

# variable "env" {
#   type        = string
#   default     = ""
#   description = "environment"
# }