resource "random_pet" "my_pet" {}

module "private-module" {
    source = "github.com/env0/blueprints-private-tf-module"
    name = "${random_pet.my_pet.id}"
}

output "message" {
  value = "${module.private-module.message}"
}
