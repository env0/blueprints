resource "aws_eip" "elk-elastic-ip" {
  instance = "${aws_instance.elk-instance.id}"
  vpc      = true
}
