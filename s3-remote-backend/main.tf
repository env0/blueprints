provider "aws" {
  assume_role {
    role_arn     = "arn:aws:iam::326535729404:role/env0_test_app"
    session_name = "env0_session"
    external_id  = "env0"
  }
}

terraform {
  backend "s3" {
    bucket = "env0-userland-remote-state-bucket"
    key    = "remote-state"
    region = "us-east-1"
  }
}

resource "aws_security_group" "security_group" {
}
