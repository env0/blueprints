resource "random_id" "id" {
  byte_length = 8
}

output "my_output" {
  value = "env0_${random_id.id.dec}"
}
