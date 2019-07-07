resource "aws_instance" "wordpress-instance" {
  ami = "ami-09568b73513c8fb4c"
  instance_type = "t2.small"
  subnet_id = "${aws_subnet.wordpress-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.wordpress-sg.id}"]
  key_name = "${aws_key_pair.wordpress-key-pair.key_name}"

  tags {
    Name = "wordpress-instance",
    CreatedBy = "env0"
    Env0 = "${random_uuid.uuid.result}"
  }
}
