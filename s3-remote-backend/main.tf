provider "aws" {
  assume_role {
    role_arn     = "${var.role_arn}"
    session_name = "env0_session"
    external_id  = "${var.external_id}"
  }
  region = "us-west-1"
}

resource "null_resource" "null" {
}

resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket-omry-test-1-12-2-32"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

variable "role_arn" {
}

variable "external_id" {
}