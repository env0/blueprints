provider "google" {
  project = "env0project"
  region  = "us-east1"
  zone    = "us-east1-b"
}

resource "google_compute_instance" "google-i" {
  name         = "gcp-test"
  machine_type = "n1-standard-1"

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
