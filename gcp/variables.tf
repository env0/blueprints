###############################################################################
# Demo Systems Sample env0 Terraform Template Configuration
# -----------------------------------------------------------------------------
# variables.tf
###############################################################################

variable "env_root_fqdn" {
  type    = string
  default = "gitlabdemo.net"
}

variable "env_username_cidr" {
  type        = string
  description = "The network /20 CIDR range for this user (Ex. 10.130.0.0/20)"
  default     = "10.130.0.0/20"
}

variable "env_username" {
  type        = string
  description = "The username that will be prefixed or tagged on all resources. (Ex. jmartin)"
  default     = "jmartin"
}

variable "gcp_image" {
  type        = string
  description = "The GCP image name. (Default: ubuntu-1804-lts)"
  default     = "ubuntu-1804-lts"
}

variable "gcp_project" {
  type        = string
  description = "The GCP project name or ID that resources will be created in."
  default     = "demosys-sandbox"
}

variable "gcp_region" {
  type        = string
  description = "The GCP region name for this environment (Ex. us-east1|europe-west1|asia-southeast1)"
  default     = "us-east1"
}

variable "gcp_region_zone" {
  type        = string
  description = "The GCP region availability zone for this environment. This must match the gcp_region. (Ex. us-east1-c|europe-west1-b|asia-southeast1-c)"
  default     = "us-east1-c"
}

variable "gke_maintenance_start_time" {
  type        = string
  description = "The start time of maintenance windows for Kubernetes operations and upgrades in HH:MM format (GMT) timezone. (Default: 03:00)"
  default     = "03:00"
}
