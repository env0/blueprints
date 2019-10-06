terraform {
  # uses tfenv to resolve minimal version:
  # https://github.com/tfutils/tfenv#min-required
  required_version  = "=0.12.3"

  backend "gcs" {
    bucket  = "tf-state-prod"
  }
}

resource "random_id" "id" {
  byte_length = 8
}

# Configure the Google Cloud provider
provider "google" {
  region  = "us-east1"
}

# Create a Google Compute Firewall
resource "google_compute_firewall" "instance" {
  name    = "terraform-example-instance${random_id.id.dec}"
  network = "default"

  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["${var.server_port}"]
  }
}

# Create a Google Compute instance
resource "google_compute_instance" "example" {
  name          = "example${random_id.id.dec}"
  machine_type  = "f1-micro"
  zone          = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  tags = ["terraform-example"]

  metadata_startup_script = "echo '<h1>Hello ${var.company_name}!</h1><img src=\"${var.company_logo}\"></img><h2>Welcome to Env0</h2>' > index.html ; nohup busybox httpd -f -p ${var.server_port} &"
}