## Demo Systems Sandbox User VPC Configuration Module

`modules/demosys-sandbox/user-vpc/`

This Terraform module is designed to be used in a parent module for creating a VPC network, subnets, and a subdomain DNS zone for the user.

This module is universally applicable to all environments and is not specific to GitLab demo systems.

### Prerequisites

There are no prerequisites. This module is usually one of the first modules called when creating a new region.

### Example Usage

See descriptions and examples of each variable in [variables.tf](variables.tf).

```
module "vpc" {
  source = "../../../../modules/demosys-sandbox/user-vpc/"

  # Required variables
  env_username = "jmartin"
  env_username_cidr = "10.130.0.0/20"
  gcp_project = "demosys-sandbox"
  gcp_region = "us-east1"
}
```

### Outputs

See definitions of each output in [outputs.tf](outputs.tf).

You can access outputs using dot notation.
```
module.vpc.outputs.var_name
```

```
vpc = {
  "dns_zone_fqdn" = "jmartin.gitlabdemo.net."
  "dns_zone_name" = "demosys-sandbox-jmartin-zone"
  "env_username" = "jmartin"
  "env_username_cidr" = "10.130.0.0/20"
  "gcp_project" = "demosys-sandbox"
  "gcp_region" = "us-east1"
  "network_self_link" = "https://www.googleapis.com/compute/v1/projects/demosys-sandbox/global/networks/demosys-sandbox-jmartin-vpc"
  "default_subnet_cidr" = "10.130.0.0/24"
  "default_subnet_name" = "demosys-sandbox-jmartin-default-subnet"
  "default_subnet_self_link" = "https://www.googleapis.com/compute/v1/projects/demosys-sandbox/regions/us-east1/subnetworks/demosys-sandbox-jmartin-default-subnet"
}
```

### Authors and Maintainers

* Jeff Martin / @jeffersonmartin / jmartin@gitlab.com
