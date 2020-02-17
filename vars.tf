# Input variable: server port
variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default = "8080"
}

variable "company_name" {
  description = "The name of the company to greet"
  default = "Hooli"
}

variable "company_logo" {
  description = "The logo of the company to greet"
  default = "https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-original-577x577/s3/032018/untitled-1_402.png?jE55z5k8TLCYRuash4OvNAA5c7zSvs_Y&itok=jshT6m-f"
}

variable "aws_region" {
  description = "The AWS region you would like Redash to be installed in"
  default = "us-east-1"
}