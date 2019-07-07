resource "aws_eip" "joomla-elastic-ip" {
  instance = "${aws_instance.joomla-instance.id}"
  vpc      = true
}
