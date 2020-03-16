terraform {
  # uses tfenv to resolve minimal version:
  # https://github.com/tfutils/tfenv#min-required
  required_version  = "=0.12.14"

  backend "gcs" {
    bucket  = "curv-env0-bucket"
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
    ports    = [var.server_port]
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
  
  metadata_startup_script = "echo '<html><head><title>Hello from env0</title><link href=\\"https://fonts.googleapis.com/css?family=Roboto&display=swap\\" rel=\\"stylesheet\\"><style> body { font-family: \\"Roboto\\"; padding-top: 50px; width: 40%;margin: auto; background-image: url(\\"https://app.env0.com/static/media/background.06648d2b.svg\\");background-size: cover;} div { display: flex; text-align: center;} .main { flex-direction: column;} .power { align-items: center; justify-content: center; margin-top: 20px;} img {border-radius: 50px;}</style></head><body><div class=\\"main\\"><h1>Welcome to your own environment ${var.companycompany_name}</h1><img alt=\\"hello\\" src=\\"https://cataas.com/cat/says/Hello%20${var.company_name}\\" /><div class=\\"power\\"><span>Powered by &nbsp;</span><a href=\\"https://www.env0.com\\"><img width=\\"100px\\" src=\\"https://assets.website-files.com/5ceab5395d0f478e169de7c0/5ceab5395d0f47937d9de7c7_Env0-Color.svg\\" /></a></div></div></body></html>' > index.html ; nohup busybox httpd -f -p ${var.server_port} &"
}
