###############################################################################
# Demo Systems Sandbox User VPC Configuration Module
# -----------------------------------------------------------------------------
# modules/demosys-sandbox/user-vpc/outputs.tf
###############################################################################

output "outputs" {
  value = {
    env_username             = var.env_username
    env_username_cidr        = var.env_username_cidr
    gcp_project              = var.gcp_project
    gcp_region               = var.gcp_region
    network_self_link        = google_compute_network.vpc.self_link
    dns_zone_name            = google_dns_managed_zone.user_zone.name
    dns_zone_fqdn            = google_dns_managed_zone.user_zone.dns_name
    default_subnet_self_link = google_compute_subnetwork.default_subnet.self_link
    default_subnet_name      = google_compute_subnetwork.default_subnet.name
    default_subnet_cidr      = google_compute_subnetwork.default_subnet.ip_cidr_range
  }
}
