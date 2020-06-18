###############################################################################
# Demo Systems Bastion Host Configuration Module
# -----------------------------------------------------------------------------
# modules/demosys-sandbox/bastion-host/variables.tf
###############################################################################

variable "dns_zone_fqdn" {
  type        = string
  description = "The FQDN of the DNS managed zone (without trailing period) that the instance hostname should be added as an A record for. (Example: us.gitlabdemo.cloud)"
}

variable "dns_zone_name" {
  type        = string
  description = "The name of the DNS managed zone that the instance hostname should be added as an A record for. This is not the FQDN of the domain. (Example: demosys-sandbox-us-zone)"
}

variable "env_username" {
  description = "Your shorthand nomenclature or handle for the environment that should be used in hostname prefixes. (Example: jmartin)"
}

variable "gcp_project" {
  type        = string
  description = "The GCP project name that is used as the prefix for names. (Example: demosys-sandbox)"
}

variable "gcp_region" {
  type        = string
  description = "The GCP region name for this environment (Ex. us-east1)"
}

variable "gcp_region_zone" {
  type        = string
  description = "The GCP region availability zone for this environment. This must match the gcp_region. (Ex. us-east1-c|eu-west1-b|asia-southeast1-c)"
}

variable "gcp_subnetwork" {
  description = "The object or self link for the subnet created in the parent module (Example: google_compute_subnetwork.mgmt_yellow_subnet.self_link)"
}

# Optional variables with default values

variable "boot_disk_size" {
  type        = string
  description = "The size in GB of the OS boot volume"
  default     = "20"
}

variable "data_disk_size" {
  type        = string
  description = "The size in GB of the data volume"
  default     = "100"
}

variable "dns_ttl" {
  type        = string
  description = "TTL of DNS Record for instance. (Default: 300)"
  default     = "300"
}

variable "enable_data_disk" {
  type        = bool
  description = "True to attach data disk. False to only have boot disk. (Default: true)"
  default     = "true"
}

variable "enable_deletion_protection" {
  description = "Instance deletion protection in GCP. The default is false for testing. Set module variable to true when environment is stable since terraform destroy will not work if this is true."
  default     = "false"
}

variable "gcp_image" {
  type        = string
  description = "The GCP image name. (Default: ubuntu-1804-lts)"
  default     = "ubuntu-1804-lts"
}

variable "gcp_machine_type" {
  description = "The size of the instance used for the Jenkins VM instance. The default is n1-standard-2, however this is a variable to allow you to adjust on a per-region basis depending on usage and performance."
  default     = "n1-standard-2"
}
