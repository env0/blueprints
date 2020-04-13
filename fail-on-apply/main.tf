terraform {
  required_version = "> 0.12.0"
}

provider "aws" {
  region  = "us-east-2"
}

variable "apply_timeout" {
  default = "10m"
}

variable "destroy_timeout" {
  default = "10m"
}

variable "instance_name" {
  default = "Namey McName"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  timeouts {
    create = var.apply_timeout
    update = var.apply_timeout
    delete = var.destroy_timeout
  }
  tags = {
    Name = var.instance_name
  }
}

resource "null_resource" "normal_resource" {
}
