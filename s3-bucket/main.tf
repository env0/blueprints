resource "aws_s3_bucket" "test_bucket" {
  bucket = "test_env0_test_bucket"
  force_destroy = true
}
