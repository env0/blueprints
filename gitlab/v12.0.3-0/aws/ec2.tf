resource "aws_instance" "gitlab-instance" {
  ami = "ami-06bad5539cac90a92"
  instance_type = "t2.small"
  subnet_id = "${aws_subnet.gitlab-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.gitlab-sg.id}"]
  key_name = "${aws_key_pair.gitlab-key-pair.key_name}"

  tags {
    Name = "gitlab-instance",
    CreatedBy = "env0"
    Env0 = "${random_uuid.uuid.result}"
  }
}
