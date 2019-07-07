resource "aws_eip" "wordpress-elastic-ip" {
  instance = "${aws_instance.wordpress-instance.id}"
  vpc      = true
}
