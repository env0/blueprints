terraform {
  required_version = "0.11.14"
}

provider "aws" {
  region = "${var.region}"
}

# Using these data sources allows the configuration to be
# generic for any region.
data "aws_region" "current" {}

data "aws_availability_zones" "available" {}
