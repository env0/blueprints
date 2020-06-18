## GitLab Demo Systems Bastion Host Configuration

`modules/demosys-sandbox/bastion-host/`

This Terraform module is designed to be used in a parent module for creating a Bastion Host instance with the needed compute instance and related tools.

This module is designed for GitLab demo systems, however it can be adapted to fit other use cases.

### Prerequisites

1. Create a VPC network and subnetwork, and provide the `self_link` in the `gcp_subnetwork` variable.
2. Determine the size of the VM that you need and update the `gcp_machine_type`.
2. Determine the short hostname that uses alphanumeric characters and hyphens. The GCP name is calculated with concatenated GCP project name, environment region (your own nomenclature), and hostname.
> `${var.gcp_project}-{$var.env_username}-${var.short_name}`

### Related Modules

* [GCP Compute Instance](../../gcp/compute-instance/README.md)

### Example Usage

See descriptions and examples of each variable in [variables.tf](variables.tf).

```
module "bastion_host" {
  source = "../../../../modules/gcp/compute-instance/"

  # Required variables
  dns_zone_fqdn   = "us.gitlabdemo.cloud"
  dns_zone_name   = "demosys-sandbox-jmartin-zone"
  env_username      = "us"
  gcp_project     = "demosys-sandbox"
  gcp_region      = "us-east1"
  gcp_region_zone = "us-east1-c"
  gcp_subnetwork  = data.google_compute_subnetwork.yellow_subnet.self_link

  # Optional variables with default values
  boot_disk_size             = "20"
  data_disk_size             = "100"
  dns_ttl                    = "300"
  enable_data_disk           = "true"
  enable_deletion_protection = "false"
  gcp_image                  = "ubuntu-1804-lts"
  gcp_machine_type           = "n1-standard-2"
}
```

### Outputs

See definitions of each output in [outputs.tf](outputs.tf).

You can access outputs using dot notation.
```
module.bastion_host.outputs.bastion_instance.var_name
```

```
bastion_host = {
  "bastion_instance" = {
    "boot_disk_size" = "10"
    "data_disk_size" = "100"
    "description" = "Bastion Host instance in us-east1-c"
    "dns_ttl" = "300"
    "enable_data_disk" = false
    "enable_deletion_protection" = false
    "external_ip" = "x.x.x.x"
    "firewall_rule_tag" = "firewall-ssh-web"
    "gcp_image" = "ubuntu-1804-lts"
    "hostname" = "bastion.us.gitlabdemo.cloud"
    "id" = "projects/demosys-sandbox/zones/us-east1-c/instances/demosys-sandbox-us-bastion"
    "internal_ip" = "x.x.x.x"
    "name" = "demosys-sandbox-us-bastion"
    "self_link" = "https://www.googleapis.com/compute/v1/projects/demosys-sandbox/zones/us-east1-c/instances/demosys-sandbox-us-bastion"
  }
}
```

### Authors and Maintainers

* Jeff Martin / @jeffersonmartin / jmartin@gitlab.com
* Cristiano Casella / @ccasella / cristiano@gitlab.com
