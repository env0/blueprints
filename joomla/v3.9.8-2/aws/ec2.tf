resource "aws_instance" "joomla-instance" {
  ami = "ami-0ce7b2d38cecf3c14"
  instance_type = "t2.small"
  subnet_id = "${aws_subnet.joomla-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.joomla-sg.id}"]
  key_name = "${aws_key_pair.joomla-key-pair.key_name}"

  tags {
    Name = "joomla-instance",
    CreatedBy = "env0"
    Env0 = "${random_uuid.uuid.result}"
  }
}