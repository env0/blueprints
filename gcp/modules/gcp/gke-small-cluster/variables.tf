###############################################################################
# Demo Systems Small-Sized (/24) GKE Cluster Configuration Module
# -----------------------------------------------------------------------------
# modules/gcp/gke-small-cluster/variables.tf
###############################################################################

# Required variables

variable "cluster_cidr" {
  type        = string
  description = "The network /24 CIDR range (Ex. 10.140.0.0/24) for this cluster"
}

variable "description" {
  type        = string
  description = "Cluster description (Ex. Kubernetes cluster for GitLab shared runners for us-east1)"
}

variable "env_username" {
  type        = string
  description = "The short name of the region used in name and DNS strings (Ex. us|eu|asia)"
}

variable "gcp_network" {
  type        = string
  description = "The object or self link for the network created in the parent module (Ex. google_compute_network.saas-vpc.self_link)"
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
  description = "The GCP region availability zone for this environment. This must match the gcp_region. (Ex. us-east1-c|europe-west1-b|asia-southeast1-c)"
}

variable "short_name" {
  type        = string
  description = "Cluster short name (Ex. gl-shared-runners). Only alphanumeric characters and hyphens are allowed. The name will be prefixed with `var.project-var.env_username-gke-` and suffixed with `-cluster` and `-nodes`, `-services`, and `-pods` for each respective IP range."
}

# Optional variables with default values

variable "dns_subdomain" {
  type        = string
  description = "Abbreviated cluster name for the subdomain (Ex. us-inst) of Kubernetes base domain (ex. .gitlabdemo.io). Only alphanumeric characters and hyphens are allowed. The name will be suffixed with the base domain."
  default     = null
}

variable "enabled" {
  type        = bool
  description = "Since the `count` parameter is not supported on modules (only for resources), we created a `enabled` variable and use it for passing the bool to the resources inside the module. Default is true."
  default     = "true"
}

variable "env_cluster_type" {
  type        = string
  description = "If env_cluster_type is `regional`, the cluster will be across 3 zones in the region. This is triple redundancy that costs 3x more than a zonal cluster. If env_cluster_type is `zonal`, the cluster will be created with 1 zone and is more cost efficient for sandbox purposes."
  default     = "zonal"
}

variable "gcp_machine_type" {
  type        = string
  description = "The GCP machine type to use for cluster nodes (Default: n1-highcpu-4)"
  default     = "n1-highcpu-4"
}

variable "gke_maintenance_start_time" {
  type        = string
  description = "The start time of maintenance windows for Kubernetes operations and upgrades in HH:MM format (GMT) timezone. (Default: 03:00)"
  default     = "03:00"
}

variable "gke_release_channel" {
  type        = string
  description = "The release channel for the cluster that is created. (Ex. UNSPECIFIED|STABLE|REGULAR|RAPID)."
  default     = "REGULAR"
}

variable "gke_version_prefix" {
  type        = string
  description = "The version number for the Kubernetes master and nodes. This is fuzz tested using the google_container_engine_versions data source to get the appropriate version number. (Ex. 1.14.)."
  default     = "1.15."
}

variable "min_node_count" {
  type        = number
  description = "The minimum number of nodes in the autoscaling node pool that should be running at any given time. This must be greater than 0 and less than local.max_node_count. (Default: 1)"
  default     = 1
}

variable "max_pods_per_node" {
  type        = number
  description = "The maximum number of pods per node. As a rule of thumb, there should be a maximum of 4 for every 1 vCPU or 1GB Memory (whichever is less). This should be adjusted based on the gcp_machine_type chosen. With the /23 CIDR range of a small cluster, we have /24 available for pods (254 addresses). With a maximum of 9 nodes in this cluster, this allows up to 28 pods per node with the appropriately sized machine type. For n1-highcpu-4 with 4 vCPU and 3.6gb memory, it is recommended to use a value of 16."
  default     = 16
}

variable "preemptible_nodes" {
  type        = bool
  description = "Preemptible VMs are Compute Engine VM instances that last a maximum of 24 hours and provide no availability guarantees. You can use preemptible VMs in your GKE clusters or node pools to run batch or fault-tolerant jobs that are less sensitive to the ephemeral, non-guaranteed nature of preemptible VMs. For better availability, use smaller machine types. https://cloud.google.com/compute/docs/instances/preemptible#preemption_process (Default: false)"
  default     = "false"
}
