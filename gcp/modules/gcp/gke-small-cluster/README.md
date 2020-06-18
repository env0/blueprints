## Small-Sized (/24) GKE Cluster Configuration Module

`modules/gcp/gke-small-cluster/`

This Terraform module is designed to be used in a parent module and will create a Google Kubernetes Engine (GKE) cluster and subnet with a primary IP range for nodes and alias/secondary ranges for services and pods.

The small-sized cluster supports 8 nodes, with 8 pods per node for a total of 64 pods.

This module is universally applicable to all environments and is not specific to GitLab demo systems.

### Prerequisites

1. Create a VPC network and provide the `self_link` in the `gcp_network` variable.
2. Allocate a `/24` CIDR range in your VPC network and specify in the `cluster_cidr` variable.

### Future Implementation

We have not implemented small clusters at GitLab yet, so this has not been extensively tested. We will likely use a dynamic count or random ID hash approach when we do within designated `/16` ranges.

### Example Usage

See descriptions and examples of each variable in [variables.tf](variables.tf).

```
module "{NAME}_cluster" {
  source      = "../../../modules/gcp/gke-small-cluster/"

  # Required variables
  # cidrsubnet(cidrsubnet("10.128.0.0/12", 4, 12), 8, 0) => 10.140.0.0/24
  cluster_cidr = "cidrsubnet(cidrsubnet(var.env_username_cidr, 4, 12), 8, 0)"
  description  = "Kubernetes cluster for {PURPOSE} in ${var.gcp_region}"
  env_username   = "us"
  gcp_network  = google_compute_network.vpc.self_link
  gcp_project  = "demosys-sandbox"
  gcp_region   = "us-east1"
  short_name   = "{name}"

  # Optional variables with default values
  enabled          = "true"
  gcp_machine_type = "n1-standard-8"
  min_node_count   = "1"
  preemptible_nodes = "false"
}
```

### Outputs

See definitions of each output in [outputs.tf](outputs.tf).

```
# Input variables
module.{NAME}_cluster.cluster_cidr
module.{NAME}_cluster.description
module.{NAME}_cluster.enabled
module.{NAME}_cluster.env_username
module.{NAME}_cluster.gcp_machine_type
module.{NAME}_cluster.gcp_network
module.{NAME}_cluster.gcp_project
module.{NAME}_cluster.gcp_region
module.{NAME}_cluster.min_node_count
module.{NAME}_cluster.preemptible_nodes
module.{NAME}_cluster.short_name

# Generated outputs for cluster subnet
module.{NAME}_cluster.subnetwork_self_link
module.{NAME}_cluster.subnetwork_nodes_name
module.{NAME}_cluster.subnetwork_nodes_cidr
module.{NAME}_cluster.subnetwork_services_name
module.{NAME}_cluster.subnetwork_services_cidr
module.{NAME}_cluster.subnetwork_pods_name
module.{NAME}_cluster.subnetwork_pods_cidr

# Generated outputs for cluster
module.{NAME}_cluster.cluster_name
module.{NAME}_cluster.cluster_username
module.{NAME}_cluster.cluster_password
module.{NAME}_cluster.cluster_endpoint
module.{NAME}_cluster.cluster_instance_group_urls
module.{NAME}_cluster.cluster_node_config
module.{NAME}_cluster.cluster_node_pools

# Generated outputs for node pool
module.{NAME}_cluster.node_pool_name
module.{NAME}_cluster.node_pool_min_node_count
module.{NAME}_cluster.node_pool_max_node_count
```

### Authors and Maintainers

* Jeff Martin / @jeffersonmartin / jmartin@gitlab.com
