# Input variable: server port
variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default = "8080"
}

variable "company_name" {
  description = "The name of the company to greet"
  default = "Hooli"
}

variable "aws_region" {
  description = "The AWS region you would like Redash to be installed in"
  default = "us-east-1"
}
