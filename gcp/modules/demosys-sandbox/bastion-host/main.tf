###############################################################################
# Demo Systems Bastion Host Configuration Module
# -----------------------------------------------------------------------------
# modules/demosys-sandbox/bastion-host/main.tf
###############################################################################

module "instance" {
  source = "../../../modules/gcp/compute-instance/"

  # Required variables
  description      = "Bastion Host instance in ${var.gcp_region_zone}"
  dns_zone_fqdn    = var.dns_zone_fqdn
  dns_zone_name    = var.dns_zone_name
  env_username     = var.env_username
  gcp_machine_type = var.gcp_machine_type
  gcp_project      = var.gcp_project
  gcp_region       = var.gcp_region
  gcp_region_zone  = var.gcp_region_zone
  gcp_subnetwork   = var.gcp_subnetwork
  short_name       = "bastion"

  # Optional variables with default values
  boot_disk_size             = var.boot_disk_size
  data_disk_size             = var.data_disk_size
  dns_ttl                    = var.dns_ttl
  enable_data_disk           = var.enable_data_disk
  enable_deletion_protection = var.enable_deletion_protection
  firewall_rule_tag          = "firewall-bastion-host"
  gcp_image                  = var.gcp_image
}
