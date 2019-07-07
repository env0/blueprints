resource "aws_eip" "neo4j-elastic-ip" {
  instance = "${aws_instance.neo4j-instance.id}"
  vpc      = true
}
