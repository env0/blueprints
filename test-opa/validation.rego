package terraform.validation

import data.terraform.library as lib

deny[msg] {
  cidr_blocks := lib.resources[r].values.ingress[x].cidr_blocks
  lib.list_contains_value(cidr_blocks, "0.0.0.0/0")
  msg = sprintf("No security groups should be open to all IP addresses. Resource in violation: %v",[r.address])
}
