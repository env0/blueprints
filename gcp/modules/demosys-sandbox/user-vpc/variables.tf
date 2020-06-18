###############################################################################
# Demo Systems Sandbox User VPC Configuration Module
# -----------------------------------------------------------------------------
# modules/demosys-sandbox/user-vpc/variables.tf
###############################################################################

variable "env_username" {
  description = "Your shorthand nomenclature or handle for the environment that should be used in hostname prefixes. (Example: jmartin)"
}

variable "env_username_cidr" {
  type        = string
  description = "The top-level CIDR range of the user VPC (Ex. 10.130.0.0/20)"
}

### TEMPORARY FOR TESTING - NORMALLY THIS IS INHERITED
variable "env_root_fqdn" {
  type        = string
  description = "The domain name that will be used for the environment."
}
### END OF TEMPORARY

variable "gcp_project" {
  type        = string
  description = "The GCP project name that is used as the prefix for names. (Example: demosys-sandbox)"
}

variable "gcp_region" {
  type        = string
  description = "The GCP region name for this environment (Ex. us-east1)"
}
