

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.66.0"
    }
  }
  backend "s3" {
    bucket         = "dvir-tf-state"
    key            = "dvir-cluster/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "tf-state"
    encrypt        = true
  }
#   backend "gcs" {
#     bucket = "<your-bucket>"
#     prefix = "terraform/state"
#   }
}

provider "google" {
  project = "develop-370223"
  region  = "me-west1-a"
}
