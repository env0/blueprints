###############################################################################
# Demo Systems Small-Sized (/24) GKE Cluster Configuration Module
# -----------------------------------------------------------------------------
# modules/gcp/gke-small-cluster/outputs.tf
###############################################################################

output "outputs" {
  value = {

    enabled     = var.enabled
    env_username  = var.env_username
    gcp_network = var.gcp_network
    gcp_project = var.gcp_project
    gcp_region  = var.gcp_region

    cluster = {
      id                     = google_container_cluster.cluster[0].id
      name                   = google_container_cluster.cluster[0].name
      short_name             = var.short_name
      description            = var.description
      username               = google_container_cluster.cluster[0].master_auth[0].username
      password               = google_container_cluster.cluster[0].master_auth[0].password
      cluster_ca_certificate = google_container_cluster.cluster[0].master_auth[0].cluster_ca_certificate
      endpoint               = google_container_cluster.cluster[0].endpoint
      instance_group_urls    = google_container_cluster.cluster[0].instance_group_urls
      # node_config            = google_container_cluster.cluster[0].node_config
      # node_pools             = google_container_cluster.cluster[0].node_pool
    }

    subnetwork = {
      self_link     = google_compute_subnetwork.subnet[0].self_link
      cluster_cidr  = var.cluster_cidr
      nodes_name    = google_compute_subnetwork.subnet[0].name
      nodes_cidr    = google_compute_subnetwork.subnet[0].ip_cidr_range
      services_name = google_compute_subnetwork.subnet[0].secondary_ip_range[0].range_name
      services_cidr = google_compute_subnetwork.subnet[0].secondary_ip_range[0].ip_cidr_range
      pods_name     = google_compute_subnetwork.subnet[0].secondary_ip_range[1].range_name
      pods_cidr     = google_compute_subnetwork.subnet[0].secondary_ip_range[1].ip_cidr_range
    }

    #    node_pool = {
    #      name              = google_container_node_pool.node_pool[0].name
    #      gcp_machine_type  = var.gcp_machine_type
    #      preemptible_nodes = var.preemptible_nodes
    #      min_node_count    = var.min_node_count
    #      max_node_count    = local.max_node_count
    #    }

  }
}
