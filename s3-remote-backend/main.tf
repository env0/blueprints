terraform {
  backend "s3" {
    bucket = "dev-userland-env0-serverless-deployment-bucket"
    key    = "remote-state"
    region = "us-east-1"
  }
}

resource "null_resource" "null" {
}