resource "aws_instance" "rabbitmq-instance" {
  ami = "ami-073cd58c618f9c878"
  instance_type = "t2.small"
  subnet_id = "${aws_subnet.rabbitmq-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.rabbitmq-sg.id}"]
  key_name = "${aws_key_pair.rabbitmq-key-pair.key_name}"

  tags {
    Name = "rabbitmq-instance",
    CreatedBy = "env0"
    Env0 = "${random_uuid.uuid.result}"
  }
}
