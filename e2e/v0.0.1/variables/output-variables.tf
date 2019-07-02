provider "aws" {
  region = var.aws_default_region
}

# Using these data sources allows the configuration to be
# generic for any region.
data "aws_region" "current" {}

data "aws_availability_zones" "available" {}

variable "terraform_variable" {
  default = "terraform_variable_NOT_SET"
}
variable "environment_variable" {
  default = "environment_variable_NOT_SET"
}
variable "aws_default_region" {
  default = "us-east-1"
}

output "terraform_variable" {
  value = var.terraform_variable
}

output "environment_variable" {
  value = var.environment_variable
}