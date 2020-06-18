###############################################################################
# Google Compute Instance Configuration Module
# -----------------------------------------------------------------------------
# modules/gcp/compute-instance/variables.tf
###############################################################################

# Required variables

variable "description" {
  type        = string
  description = "Instance description. (Example: App server for a cool purpose in us-east1-c)"
}

variable "dns_zone_fqdn" {
  type        = string
  description = "The FQDN of the DNS managed zone (with or without trailing period) that the instance hostname should be added as an A record for. (Example: us.gitlabdemo.cloud)"
}

variable "dns_zone_name" {
  type        = string
  description = "The name of the DNS managed zone that the instance hostname should be added as an A record for. This is not the FQDN of the domain. (Example: demosys-sandbox-us-zone)"
}

variable "env_username" {
  description = "Your shorthand nomenclature for the environment region that should be used in hostname prefixes. (Example: us|eu|asia|global)"
}

variable "gcp_machine_type" {
  type        = string
  description = "The GCP machine type (Example: n1-standard-2|n1-standard-8)"
}

variable "gcp_project" {
  type        = string
  description = "The GCP project name that is used as the prefix for names. (Example: demosys-sandbox)"
}

variable "gcp_region" {
  type        = string
  description = "The GCP region name for this environment (Ex. us-east1|eu-west1|asia-southeast1)"
}

variable "gcp_region_zone" {
  type        = string
  description = "The GCP region availability zone for this environment. This must match the region. (Example: us-east1-c|eu-west1-b|asia-southeast1-c)"
}

variable "gcp_subnetwork" {
  description = "The object or self link for the subnet created in the parent module (Example: google_compute_subnetwork.mgmt_yellow_subnet.self_link)"
}

variable "short_name" {
  type        = string
  description = "The short name (hostname) of the VM instance that will become an A record in the DNS zone that you specify. The GCP name is calculated with concatenated GCP project name, environment region, and hostname. (Example: app1)"
}

# Optional variables with default values

variable "boot_disk_size" {
  type        = string
  description = "The size in GB of the OS boot volume. (Default: 10)"
  default     = "10"
}

variable "data_disk_size" {
  type        = string
  description = "The size in GB of the data volume. (Default: 100)"
  default     = "100"
}

variable "dns_ttl" {
  type        = string
  description = "TTL of DNS Record for instance. (Default: 300)"
  default     = "300"
}

variable "enable_data_disk" {
  type        = bool
  description = "True to attach data disk. False to only have boot disk. (Default: false)"
  default     = "false"
}

variable "enable_deletion_protection" {
  type        = bool
  description = "Enable this to prevent Terraform from accidentally destroying the instance with terraform destroy command. (Default: false)"
  default     = "false"
}

variable "firewall_rule_tag" {
  type        = string
  description = "Tag for the existing firewall rule set that you want to apply for ingress traffic. (Default: firewall-ssh-web)"
  default     = "firewall-ssh-web"
}

variable "gcp_image" {
  type        = string
  description = "The GCP image name. (Default: ubuntu-1804-lts)"
  default     = "ubuntu-1804-lts"
}
