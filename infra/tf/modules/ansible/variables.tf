variable "HA" {
  description = "High  Availability - to determinbe if the cluster uses multi control plane or not"
  type        = bool
}

variable "controllers" {
  description = "controllers hosts"
}

variable "workers" {
  description = "workers hosts"
}