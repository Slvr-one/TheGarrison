variable "profile" {
  description = "AWS profile"
  type        = string
}

variable "region" {
  description = "AWS region to deploy to"
  default     = "eu-west-1"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "tags" {
  description = "general tags; Owner, exp_date, bootcamp"
  type        = map(any)
}

# variable "env" {
#   type        = string
#   description = "environment"
# }