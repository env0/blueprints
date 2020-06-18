###############################################################################
# Demo Systems Sandbox User VPC Configuration Module
# -----------------------------------------------------------------------------
# modules/demosys-sandbox/user-vpc/main.tf
###############################################################################

### TEMPORARY FOR TESTING - NORMALLY THIS IS INHERITED
# Create zone for root level domain
# Do not change the `name` of this resource since it is used as a data resource
resource "google_dns_managed_zone" "root_zone" {
  name        = "demosys-sandbox-root-zone"
  dns_name    = "${var.env_root_fqdn}."
  description = "Root managed DNS zone for ${var.env_root_fqdn}"
}
### END OF TEMPORARY

# Create VPC network for environment resources
resource "google_compute_network" "vpc" {
  auto_create_subnetworks = "false"
  description             = "VPC for ${var.gcp_project} ${var.env_username} (${var.gcp_region}) demo resources"
  name                    = "${var.gcp_project}-${var.env_username}-vpc"
  routing_mode            = "REGIONAL"
}

###############################################################################
# Create GCP Cloud DNS Managed Zone for Region with Subdomain
# -----------------------------------------------------------------------------
#
###############################################################################

# Get root-level DNS zone
data "google_dns_managed_zone" "root_zone" {
  name = google_dns_managed_zone.root_zone.name
  #  name = "${var.gcp_project}-root-zone"
}

# Create zone for region level domain
# Do not change the `name` of this resource since it is used as a data resource
resource "google_dns_managed_zone" "user_zone" {
  description = "User managed DNS zone for ${var.env_username}.${data.google_dns_managed_zone.root_zone.dns_name}"
  dns_name    = "${var.env_username}.${data.google_dns_managed_zone.root_zone.dns_name}"
  name        = "${var.gcp_project}-${var.env_username}-zone"
  /*
  visibility = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.mgmt-vpc.self_link
    }
  }
  */
}

# Create DNS record with each of the four NS records to add to root level domain
# for subdomain zone. The TTL is intentionally set at 300 in case we need to
# rebuild a region.
resource "google_dns_record_set" "dns_record" {
  managed_zone = data.google_dns_managed_zone.root_zone.name
  name         = "${var.env_username}.${data.google_dns_managed_zone.root_zone.dns_name}"
  rrdatas      = google_dns_managed_zone.user_zone.name_servers
  ttl          = "300"
  type         = "NS"
}

###############################################################################
# Create GCP VPC Subnetworks
# -----------------------------------------------------------------------------
#
###############################################################################

# Create subnet for low security (YELLOW) application resources
# cidrsubnet("10.130.0.0/20", 4, 0) => 10.130.0.0/24
resource "google_compute_subnetwork" "default_subnet" {
  description   = "User default subnet for ${var.env_username} in ${var.gcp_region}"
  ip_cidr_range = cidrsubnet(var.env_username_cidr, 4, 0)
  name          = "${var.gcp_project}-${var.env_username}-default-subnet"
  network       = google_compute_network.vpc.self_link
  region        = var.gcp_region
}

###############################################################################
# Create GCP Cloud Router and NAT Gateway
# -----------------------------------------------------------------------------
#
###############################################################################

resource "google_compute_router" "router" {
  name    = "${var.gcp_project}-${var.env_username}-router"
  network = google_compute_network.vpc.name
  region  = var.gcp_region
}

resource "google_compute_router_nat" "nat_gateway" {
  name                               = "${var.gcp_project}-${var.env_username}-nat-gateway"
  nat_ip_allocate_option             = "AUTO_ONLY"
  router                             = google_compute_router.router.name
  region                             = var.gcp_region
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = "false"
    filter = "ALL"
  }
}

###############################################################################
# Create GCP Firewall Rules
# -----------------------------------------------------------------------------
#
###############################################################################

# Create firewall rules for web server instances
resource "google_compute_firewall" "firewall_ssh_web" {
  name    = "${var.gcp_project}-${var.env_username}-firewall-ssh-web"
  network = google_compute_network.vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  target_tags = ["firewall-ssh-web"]
}

# Create firewall rules for GitLab instances
# https://docs.gitlab.com/omnibus/package-information/defaults.html
resource "google_compute_firewall" "firewall_gitlab_instance" {
  name    = "${var.gcp_project}-${var.env_username}-firewall-gitlab-instance"
  network = google_compute_network.vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "143", "443", "5000", "5050", "9090"]
  }

  target_tags = ["firewall-gitlab-instance"]
}

# Create firewall rules for bastion host instances
resource "google_compute_firewall" "firewall_bastion_host" {
  name    = "${var.gcp_project}-${var.env_username}-firewall-bastion-host"
  network = google_compute_network.vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["firewall-bastion-host"]
}
