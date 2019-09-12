resource "null_resource" "null" {
}

terraform {
  backend "gcs" {
    bucket = "curv-terraform-state-bucket"
    credentials = "gcp-credentials.json"
  }
}

provider "aws" {
  region = "us-east-1"
}