###############################################################################
# Demo Systems Sample env0 Terraform Template Configuration
# -----------------------------------------------------------------------------
# main.tf
###############################################################################

# Define the Google Cloud Provider
provider "google" {
  project     = var.gcp_project
  version     = "~> 3.26"
}

# Define the Google Cloud Provider
provider "google-beta" {
  project     = var.gcp_project
  version     = "~> 3.26"
}

# Create the network configuration for the region
module "user_vpc" {
  source = "./modules/demosys-sandbox/user-vpc/"

  env_root_fqdn     = var.env_root_fqdn
  env_username      = var.env_username
  env_username_cidr = var.env_username_cidr
  gcp_project       = var.gcp_project
  gcp_region        = var.gcp_region
}

# Create the Bastion host instance
module "bastion_host" {
  source = "./modules/demosys-sandbox/bastion-host/"

  # Required variables
  dns_zone_fqdn   = module.user_vpc.outputs.dns_zone_fqdn
  dns_zone_name   = module.user_vpc.outputs.dns_zone_name
  env_username    = var.env_username
  gcp_project     = var.gcp_project
  gcp_region      = var.gcp_region
  gcp_region_zone = var.gcp_region_zone
  gcp_subnetwork  = module.user_vpc.outputs.default_subnet_self_link

  # Optional variables with default values
  boot_disk_size             = "20"
  data_disk_size             = "100"
  dns_ttl                    = "300"
  enable_data_disk           = "false"
  enable_deletion_protection = "false"
  gcp_image                  = "ubuntu-1804-lts"
  gcp_machine_type           = "n1-standard-1"

  # TODO Change enable_deletion_protection to true once environment is stable
}

module "cluster_jmartin" {
  source = "./modules/gcp/gke-small-cluster/"

  # cidrsubnet("10.130.0.0/20", 3, 5) => 10.130.10.0/23
  # cidrsubnet("10.130.0.0/20", 3, 6) => 10.130.12.0/23
  # cidrsubnet("10.130.0.0/20", 3, 7) => 10.130.14.0/23
  cluster_cidr               = cidrsubnet(var.env_username_cidr, 3, 5)
  description                = "Test autoscaling cluster"
  enabled                    = true
  env_username               = var.env_username
  gcp_machine_type           = "n1-highcpu-4"
  gcp_network                = module.user_vpc.outputs.network_self_link
  gcp_project                = var.gcp_project
  gcp_region                 = var.gcp_region
  gcp_region_zone            = var.gcp_region_zone
  gke_maintenance_start_time = var.gke_maintenance_start_time
  gke_release_channel        = "UNSPECIFIED"
  gke_version_prefix         = "1.15."
  short_name                 = "test-cluster"
}
