resource "aws_s3_bucket" "test_bucket" {
  bucket = "test-env0-test-bucket"
  force_destroy = true
}
