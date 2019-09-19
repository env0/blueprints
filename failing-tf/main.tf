resource "null_resource" "good" {
}

resource "null_resource" "bad" {
    not_a_prop = "no!"
}