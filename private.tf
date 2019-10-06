resource "random_pet" "my_pet" {}

module "private-module" {
  source = "git::git@github.com:env0/blueprints-private-tf-module.git"
  name = "${random_pet.my_pet.id}"
}

output "message" {
  value = "${module.private-module.message}"
}
