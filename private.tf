resource "random_pet" "my_pet" {}

module "private-module" {
  source = "git::git@github.com:env0/blueprints-private-tf-module.git"
  name = random_pet.my_pet.id
}

output "message" {
  value = module.private-module.message
}

module "redash" {
  source = "git::git@github.com:env0/blueprints.git//redash/v5.0.2/aws?ref=redash-module"
  aws_default_region = var.aws_region
}

output "redash_ip" {
  value = module.redash.instance_public_ip
}