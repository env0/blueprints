###############################################################################
# Demo Systems Sample env0 Terraform Template Outputs
# -----------------------------------------------------------------------------
# outputs.tf
###############################################################################

output "region_variables" {
  value = {
    env_root_fqdn     = var.env_root_fqdn
    env_username      = var.env_username
    env_username_cidr = var.env_username_cidr
    gcp_image         = var.gcp_image
    gcp_project       = var.gcp_project
    gcp_region        = var.gcp_region
    gcp_region_zone   = var.gcp_region_zone
  }
}

output "user_vpc" {
  value = module.user_vpc.outputs
}

output "bastion_host" {
  value = module.bastion_host.outputs
}

output "cluster_jmartin" {
  value = module.cluster_jmartin.outputs
}
