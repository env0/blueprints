resource "aws_s3_bucket" "b" {
  bucket = "env0-my-tf-test-bucket"
  acl    = "public-read"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["https://s3-website-test.hashicorp.com"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3001
  }
}

terraform {
  backend "s3" {
    bucket = "env0-terraform-backend-test"
    key    = "test-state"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}