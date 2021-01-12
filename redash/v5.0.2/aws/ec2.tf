resource "aws_instance" "redash-instance" {
  ami = "ami-0d915a031cabac0e0"
  instance_type = "${var.instance_type}"
  subnet_id = "${aws_subnet.redash-subnet[0].id}"
  vpc_security_group_ids = ["${aws_security_group.redash-sg.id}"]
  key_name = "${aws_key_pair.redash-key-pair.key_name}"

  tags {
    Name = "redash-instance"
    CreatedBy = "env0"
  }
}
