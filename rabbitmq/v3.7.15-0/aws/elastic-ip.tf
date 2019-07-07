resource "aws_eip" "rabbitmq-elastic-ip" {
  instance = "${aws_instance.rabbitmq-instance.id}"
  vpc      = true
}
