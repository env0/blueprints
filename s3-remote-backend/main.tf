provider "aws" {
  assume_role {
    role_arn     = "${var.role_arn}"
    session_name = "env0_session"
    external_id  = "${var.external_id}"
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

variable "role_arn" {
  type = string
}

variable "external_id" {
  type = string
}