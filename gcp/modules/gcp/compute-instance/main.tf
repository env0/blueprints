###############################################################################
# Google Compute Instance Configuration Module
# -----------------------------------------------------------------------------
# modules/gcp/compute-instance/main.tf
###############################################################################

# The trimsuffix function is used to remove the trailing decimals from the FQDN
# since some variables will include the DNS zone with a trailing period and
# other variables may affix an extra decimal (two total). By removing the
# decimals, we can have predictability and them in where appropriate for
# the hostname (no decimal) and DNS record (decimal)

locals {
  instance_name = "${var.gcp_project}-${var.env_username}-${var.short_name}"
  instance_fqdn = trimsuffix(trimsuffix("${var.short_name}.${var.dns_zone_fqdn}", ".."), ".")
}

# Create additional disk volume for instance
resource "google_compute_disk" "data_disk" {
  count = var.enable_data_disk ? 1 : 0

  labels = { host = local.instance_name }
  name   = "${local.instance_name}-data-disk"
  size   = var.data_disk_size
  type   = "pd-ssd"
  zone   = var.gcp_region_zone
}

# Attach additional disk to instance, so that we can move this
# volume to another instance if needed later.
# This will appear at /dev/disk/by-id/google-{NAME}
resource "google_compute_attached_disk" "attach_data_disk" {
  count = var.enable_data_disk ? 1 : 0

  device_name = "data-disk"
  disk        = google_compute_disk.data_disk[0].self_link
  instance    = google_compute_instance.instance.self_link
}

# Create an external IP for the instance
resource "google_compute_address" "external_ip" {
  address_type = "EXTERNAL"
  description  = "External IP for ${var.description}"
  name         = "${local.instance_name}-external-ip"
  region       = var.gcp_region
}

# Create a Google Compute Engine VM instance
resource "google_compute_instance" "instance" {
  description         = var.description
  deletion_protection = var.enable_deletion_protection
  hostname            = local.instance_fqdn
  name                = local.instance_name
  machine_type        = var.gcp_machine_type
  zone                = var.gcp_region_zone

  # Base disk for the OS
  boot_disk {
    initialize_params {
      type  = "pd-ssd"
      image = var.gcp_image
      size  = var.boot_disk_size
    }
    auto_delete = "true"
  }

  # This ignored_changes is required since we use a separate resource for attaching the disk
  lifecycle {
    ignore_changes = [attached_disk]
  }

  # Attach the primary network interface to the VM
  network_interface {
    subnetwork = var.gcp_subnetwork
    access_config {
      nat_ip = google_compute_address.external_ip.address
    }
  }

  # This sets a custom SSH key on the instance and prevents the OS Login and GCP
  # project-level SSH keys from working. This is commented out since we use
  # project-level SSH keys.
  # https://console.cloud.google.com/compute/metadata?project=demosys-sandbox&authuser=1&supportedpurview=project
  #
  # We have created a custom SSH key that can be found in the 1Password vault
  # `Demo Systems Admin - Google Cloud Instance SSH Key` to access using SSH.
  #
  # metadata {
  #   sshKeys = "ubuntu:${file("../../../keys/${var.ssh_public_key}.pub")}"
  # }

  scheduling {
    on_host_maintenance = "MIGRATE"
    automatic_restart   = "true"
    preemptible         = "false"
  }

  tags = ["${local.instance_name}", "${var.firewall_rule_tag}"]

}

# Create a DNS record
resource "google_dns_record_set" "dns_record" {
  managed_zone = var.dns_zone_name
  name         = "${local.instance_fqdn}."
  rrdatas      = [google_compute_address.external_ip.address]
  ttl          = var.dns_ttl
  type         = "A"
}
