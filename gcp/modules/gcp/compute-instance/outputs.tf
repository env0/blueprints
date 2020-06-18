###############################################################################
# Google Compute Instance Configuration Module
# -----------------------------------------------------------------------------
# modules/gcp/compute-instance/outputs.tf
###############################################################################

# Input Variables

output "outputs" {
  value = {
    boot_disk_size             = var.boot_disk_size
    data_disk_size             = var.data_disk_size
    description                = google_compute_instance.instance.description
    dns_ttl                    = var.dns_ttl
    dns_zone_fqdn              = var.dns_zone_fqdn
    dns_zone_name              = var.dns_zone_name
    enable_data_disk           = var.enable_data_disk
    enable_deletion_protection = var.enable_deletion_protection
    env_username                 = var.env_username
    external_ip                = google_compute_address.external_ip.address
    firewall_rule_tag          = var.firewall_rule_tag
    hostname                   = google_compute_instance.instance.hostname
    gcp_image                  = var.gcp_image
    gcp_machine_type           = var.gcp_machine_type
    gcp_project                = var.gcp_project
    gcp_region                 = var.gcp_region
    gcp_region_zone            = var.gcp_region_zone
    gcp_subnetwork             = var.gcp_subnetwork
    id                         = google_compute_instance.instance.id
    internal_ip                = google_compute_instance.instance.network_interface[0].network_ip
    name                       = google_compute_instance.instance.name
    self_link                  = google_compute_instance.instance.self_link
    short_name                 = var.short_name
  }
}

output "description" {
  value = google_compute_instance.instance.description
}

output "env_username" {
  value = var.env_username
}

output "firewall_rule_tag" {
  value = var.firewall_rule_tag
}

output "gcp_image" {
  value = var.gcp_image
}

output "gcp_machine_type" {
  value = var.gcp_machine_type
}

output "gcp_project" {
  value = var.gcp_project
}

output "gcp_region" {
  value = var.gcp_region
}

output "gcp_region_zone" {
  value = var.gcp_region_zone
}

output "gcp_subnetwork" {
  value = var.gcp_subnetwork
}

output "short_name" {
  value = var.short_name
}

# Generated Ouputs

output "hostname" {
  value = google_compute_instance.instance.hostname
}

output "id" {
  value = google_compute_instance.instance.id
}

output "name" {
  value = google_compute_instance.instance.name
}

output "internal_ip" {
  value = google_compute_instance.instance.network_interface[0].network_ip
}

output "external_ip" {
  value = google_compute_address.external_ip.address
}

output "self_link" {
  value = google_compute_instance.instance.self_link
}
