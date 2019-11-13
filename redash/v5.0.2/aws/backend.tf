terraform {
  backend "s3" {
    bucket = "env0-userland-remote-state-bucket"
    key    = "remote-state"
    region = "us-east-1"
  }
}
