## GCP Compute Instance Configuration with DNS Record

`modules/gcp/compute-instance/`

This Terraform module is designed to be used in a parent module for creating a compute instance with associated DNS record.

This module is universally applicable to all environments and is not specific to GitLab demo systems.

### Prerequisites

1. Create a VPC network and subnetwork, and provide the `self_link` in the `gcp_subnetwork` variable.
2. Determine the short hostname that uses alphanumeric characters and hyphens. The GCP name is calculated with concatenated GCP project name, environment region (your own nomenclature), and hostname.
> `${var.gcp_project}-{$var.env_username}-${var.short_name}`

### Related Modules

* No related modules

### Example Usage

See descriptions and examples of each variable in [variables.tf](variables.tf).

```
module "{NAME}_instance" {
    source = "../../../../modules/gcp/compute-instance/"

    # Required variables
    description = "App server for a cool purpose in us-east1-c"
    dns_zone_name = data.google_dns_managed_zone.{NAME}.name
    env_username = "us"
    gcp_machine_type = "n1-standard-2"
    gcp_project = "demosys-sandbox"
    gcp_region = "us-east1"
    gcp_region_zone = "us-east1-c"
    gcp_subnetwork = google_compute_subnetwork.{RESOURCE_NAME}.self_link
    short_name = "app1"

    # Optional variables with default values
    boot_disk_size = "10"
    data_disk_size = "100"
    dns_ttl = "300"
    enable_data_disk = "false"
    enable_deletion_protection = "false"
    firewall_rule_tag = "firewall-ssh-web"
    gcp_image = "ubuntu-1804-lts"
}
```

### Outputs

See definitions of each output in [outputs.tf](outputs.tf).

```
# Input variables
module.{NAME}_instance.description
module.{NAME}_instance.env_username
module.{NAME}_instance.firewall_rule_tag
module.{NAME}_instance.gcp_image
module.{NAME}_instance.gcp_machine_type
module.{NAME}_instance.gcp_project
module.{NAME}_instance.gcp_region
module.{NAME}_instance.gcp_region_zone
module.{NAME}_instance.gcp_subnetwork
module.{NAME}_instance.short_name

# Generated outputs
module.{NAME}_instance.fqdn
module.{NAME}_instance.id
module.{NAME}_instance.name
module.{NAME}_instance.hostname
module.{NAME}_instance.internal_ip
module.{NAME}_instance.external_ip
module.{NAME}_instance.self_link
```

### Authors and Maintainers

* Jeff Martin / @jeffersonmartin / jmartin@gitlab.com
