terraform {
  backend "s3" {
    bucket = "env0-temp-remote-state-bucket"
    key    = "remote-state"
    region = "us-east-1"
  }
}

resource "null_resource" "null" {
}
