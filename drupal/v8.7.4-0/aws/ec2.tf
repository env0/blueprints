resource "aws_instance" "drupal-instance" {
  ami = "ami-0b12f26e79c47dbff"
  instance_type = "t2.small"
  subnet_id = "${aws_subnet.drupal-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.drupal-sg.id}"]
  key_name = "${aws_key_pair.drupal-key-pair.key_name}"

  tags {
    Name = "drupal-instance",
    CreatedBy = "env0"
    Env0 = "${random_uuid.uuid.result}"
  }
}
