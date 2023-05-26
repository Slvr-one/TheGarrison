

# https://www.terraform.io/language/settings/backends/gcs
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.66.0"
    }
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
