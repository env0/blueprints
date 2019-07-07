resource "aws_instance" "neo4j-instance" {
  ami = "ami-07f2c3414f877097f"
  instance_type = "t2.small"
  subnet_id = "${aws_subnet.neo4j-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.neo4j-sg.id}"]
  key_name = "${aws_key_pair.neo4j-key-pair.key_name}"

  tags {
    Name = "neo4j-instance",
    CreatedBy = "env0"
    Env0 = "${random_uuid.uuid.result}"
  }
}
