provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "good-bucket" {
    # terraform will give this bucket a random name
}

resource "aws_s3_bucket" "bad-bucket" {
    bucket = "no"
    # this bucket name will not work, but will only fail during 'apply'
}