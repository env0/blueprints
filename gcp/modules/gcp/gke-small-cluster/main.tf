###############################################################################
# Demo Systems Small-Sized (/23) GKE Cluster Configuration Module
# -----------------------------------------------------------------------------
# modules/gcp/gke-small-cluster/main.tf
# -----------------------------------------------------------------------------
# If env_cluster_type is `regional`, the cluster will be across 3 zones in the
# region. This is triple redundancy that costs 3x more than a zonal cluster.
# If env_cluster_type is `zonal`, the cluster will be created with 1 zone and
# is more cost efficient for sandbox purposes.
###############################################################################

locals {
  cluster_name_prefix = "demosys-${var.env_username}-${var.short_name}"
  max_node_count      = var.env_cluster_type == "regional" ? 3 : 9

  # For regional clusters, the max_node_count is calculated by taking the max
  # number of IP addresses for nodes (8) and dividing by 3 (number of nodes
  # created across each zone, a GKE default behavior), and rounding down to
  # nearest whole number (2).
}

data "google_container_engine_versions" "version" {
  provider       = google-beta
  location       = var.env_cluster_type == "regional" ? var.gcp_region : var.gcp_region_zone
  version_prefix = var.gke_version_prefix
}

resource "random_string" "cluster_basic_auth_password" {
  length           = 16
  special          = false
  override_special = "/@£$"
}

# Create subnet for GKE small-sized (/23) cluster
resource "google_compute_subnetwork" "subnet" {
  count = var.enabled ? 1 : 0

  description              = "Subnet for ${var.description}"
  name                     = "${local.cluster_name_prefix}-subnet-nodes"
  network                  = var.gcp_network
  private_ip_google_access = "true"
  region                   = var.gcp_region

  # Node IPs - cidrsubnet("10.140.0.0/23", 4, 0) => 10.140.0.0/27
  ip_cidr_range = cidrsubnet(var.cluster_cidr, 4, 0)

  secondary_ip_range {
    range_name = "${local.cluster_name_prefix}-subnet-services"
    # Services IPs - cidrsubnet("10.140.0.0/23", 2, 1) => 10.140.0.128/25
    ip_cidr_range = cidrsubnet(var.cluster_cidr, 2, 1)
  }

  secondary_ip_range {
    range_name = "${local.cluster_name_prefix}-subnet-pods"
    # Pod IPs - cidrsubnet("10.140.0.0/23", 1, 1) => 10.140.1.0/24
    ip_cidr_range = cidrsubnet(var.cluster_cidr, 1, 1)
  }

}

# Create Kubernetes cluster on GKE
resource "google_container_cluster" "cluster" {
  count = var.enabled ? 1 : 0

  description        = var.description
  location           = var.env_cluster_type == "regional" ? var.gcp_region : var.gcp_region_zone
  min_master_version = data.google_container_engine_versions.version.latest_master_version
  name               = local.cluster_name_prefix
  network            = var.gcp_network
  provider           = google-beta

  # Node IPs
  subnetwork = google_compute_subnetwork.subnet[0].self_link

  ip_allocation_policy {
    # Pod IPs
    cluster_secondary_range_name = "${local.cluster_name_prefix}-subnet-pods"
    # Services IPs
    services_secondary_range_name = "${local.cluster_name_prefix}-subnet-services"
  }

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool  = true
  initial_node_count        = 1
  default_max_pods_per_node = var.max_pods_per_node

  maintenance_policy {
    daily_maintenance_window {
      start_time = var.gke_maintenance_start_time
    }
  }

  # If this block is provided and both username and password are empty, basic authentication will be disabled.
  master_auth {
    username = "admin"
    password = random_string.cluster_basic_auth_password.result

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  # As of 2020-05-22, this is only available in the `google-beta` provider. If
  # using the `google` provider, change at the top of the `environments/*` file.
  # Beta GCP features have no deprecation policy and no SLA, but are otherwise
  # considered to be feature-complete with only minor outstanding issues.
  # https://www.terraform.io/docs/providers/google/guides/provider_versions.html
  release_channel {
    channel = var.gke_release_channel
  }

  addons_config {
    horizontal_pod_autoscaling {
      disabled = "false"
    }
  }

  /*
  # TODO Configure autoscaling resource limits
  cluster_autoscaling {
    enabled = "true"
    resource_limits {
      resource_type = "cpu"
      minimum       = ""
      maximum       = ""
    }
    resource_limits {
      resource_type = "memory"
      minimum       = ""
      maximum       = ""
    }
  }
  */
}

# Create an independently managed node pool for the cluster
resource "google_container_node_pool" "node_pool" {
  count = var.enabled ? 1 : 0

  cluster            = google_container_cluster.cluster[0].name
  initial_node_count = var.min_node_count
  location           = var.env_cluster_type == "regional" ? var.gcp_region : var.gcp_region_zone
  name               = "${local.cluster_name_prefix}-node-pool"
  version            = data.google_container_engine_versions.version.latest_node_version

  lifecycle {
    ignore_changes = [initial_node_count]
  }

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = local.max_node_count
  }

  management {
    auto_upgrade = false
  }

  node_config {
    preemptible  = var.preemptible_nodes
    machine_type = var.gcp_machine_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
