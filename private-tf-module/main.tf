resource "random_pet" "my_pet" {}

module "private-module" {
  # The SSH username is taken from AWS IAM -> User -> SSH Keys
  source = "git::ssh://APKASPLLFUTOMAQFRUON@git-codecommit.us-east-1.amazonaws.com/v1/repos/private-tf-module"
  name = "${random_pet.my_pet.id}"
}

output "message" {
  value = "${module.private-module.message}"
}
