provider "google" {
  project = "env0project"
  region  = "us-east1"
  zone    = "us-east1-b"
}

provider "aws" {
  region = "us-east-1"

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

resource "aws_instance" "instance1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.small"
  subnet_id = "subnet-06008a79bd3b694c6"
  
  tags = {
    "Name" = "yaron-test"
  }
}

resource "google_compute_instance" "instance2" {
  name         = "yaron-test"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config {
    }
  }
}
