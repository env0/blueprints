variable "image1" {
  default = "a"
}


resource "null_resource" "null" {
}

output "image1_length" {
  value = "${length(var.image1)}"
}
