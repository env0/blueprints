# This resource will destroy (potentially immediately) after null_resource.next
resource "null_resource" "previous" {}

resource "time_sleep" "wait_1000_seconds" {
  depends_on = [null_resource.previous]

  create_duration = "1000s"
}

# This resource will create (at least) 1000 seconds after null_resource.previous
resource "null_resource" "next" {
  depends_on = [time_sleep.wait_1000_seconds]
}
