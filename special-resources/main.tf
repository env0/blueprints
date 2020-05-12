variable "list_ids" {
  type = list(string)
  default = ["some.thing.is.great","other.thing.is.great", "the.last_dance)(*&?%$2##@!2"]
}

resource "null_resource" "null_very_null" {
  for_each = toset(var.list_ids)
}

resource "random_pet" "random_pet" {
  for_each = toset(var.list_ids)
}


module "kubeadm-token" {
  source = "github.com/scholzj/terraform-kubeadm-token"
}

module "files" {
  source  = "matti/resource/shell"
  command = "ls -l"
}

resource "random_string" "random" {
  for_each = toset(var.list_ids)
  length = length(module.kubeadm-token.token)
  override_special = module.kubeadm-token.token
}

output "new_token" {
  value = module.kubeadm-token.token
}

output "greeting" {
  value = module.files.stdout
}
