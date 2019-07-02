# using these data sources allows the configuration to be generic for any region.
data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

variable "terraform_variable" { default = "terraform_variable_NOT_SET" }
variable "environment_variable" { default = "environment_variable_NOT_SET" }

provider "aws" {
  region = "us-east-1"
}

output "terraform_variable" {
  value = "${var.terraform_variable}"
}

output "environment_variable" {
  value = "${var.environment_variable}"
}