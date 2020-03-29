provider "aws" {
  region  = "us-east-1"
}

resource "aws_s3_bucket" "bad_bucket" {
  bucket = "bad name for a bucket"
}
