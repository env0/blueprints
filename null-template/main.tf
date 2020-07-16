resource "null_resource" "null" {
}

resource "null_resource" "null2" {
}

resource "null_resource" "example1" {
  provisioner "local-exec" {
    command = "./test.sh"
  }
}

resource "null_resource" "example2" {
  provisioner "local-exec" {
    command = "./test.sh"
  }
}