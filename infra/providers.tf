
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.47.0" #"~> 3.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.8.0"
    }
    # kubernetes = {
    #   source  = "hashicorp/kubernetes"
    #   version = "2.16.1"
    # }
    # tls = {
    #   source  = "hashicorp/tls"
    #   version = "4.0.4"
    # }
    # kubectl = { //enabling the server-side apply on the kubectl provider.
    #   source  = "gavinbunney/kubectl"
    #   version = ">= 1.7.0"
    # }
  }

  backend "s3" {
    bucket         = "dvir-tf-state"
    key            = "dvir-cluster/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "tf-state"
    encrypt        = true
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile #"default"
}

provider "helm" {
  kubernetes {
    host                   = module.eks.host
    cluster_ca_certificate = base64decode(module.eks.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-id", module.eks.cluster_id]
    }
  }
}


  