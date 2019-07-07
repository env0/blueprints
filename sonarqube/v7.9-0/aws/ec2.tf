resource "aws_instance" "sonarqube-instance" {
  ami = "ami-020ac8677f2ba2879"
  instance_type = "t2.small"
  subnet_id = "${aws_subnet.sonarqube-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.sonarqube-sg.id}"]
  key_name = "${aws_key_pair.sonarqube-key-pair.key_name}"

  tags {
    Name = "sonarqube-instance",
    CreatedBy = "env0"
    Env0 = "${random_uuid.uuid.result}"
  }
}
