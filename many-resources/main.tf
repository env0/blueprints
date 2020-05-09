resource "null_resource" "null" {
  count = 50
}

resource "null_resource" "null2" {
  count = 20
}

resource "random_uuid" "test" {
  count = 100
}

resource "random_pet" "pet" {
  count = 60
}

resource "time_static" "example" {
  count = 10
}

module "kubeadm-token" {
  source = "github.com/scholzj/terraform-kubeadm-token"
}

output "new_token" {
  value = module.kubeadm-token.token
}
