resource "aws_instance" "test" {
  ami = "ami-11111"
  instance_type = "t3.micro"
}