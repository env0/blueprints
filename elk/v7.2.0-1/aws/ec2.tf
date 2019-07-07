resource "aws_instance" "elk-instance" {
  ami = "ami-0ed43e9f692d4dc19"
  instance_type = "t2.small"
  subnet_id = "${aws_subnet.elk-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.elk-sg.id}"]
  key_name = "${aws_key_pair.elk-key-pair.key_name}"

  tags {
    Name = "elk-instance",
    CreatedBy = "env0"
    Env0 = "${random_uuid.uuid.result}"
  }
}
