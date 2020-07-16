# This resource will destroy (potentially immediately) after null_resource.next
resource "null_resource" "previous" {}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [null_resource.previous]

  create_duration = "120s"
}

# This resource will create (at least) 1000 seconds after null_resource.previous
resource "null_resource" "next" {
  depends_on = [time_sleep.wait_30_seconds]
}

resource "time_sleep" "wait_again" {
  depends_on = [null_resource.next]

  create_duration = "60s"
}

resource "null_resource" "last" {
  depends_on = [time_sleep.wait_again]
}
