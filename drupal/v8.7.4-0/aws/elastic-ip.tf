resource "aws_eip" "drupal-elastic-ip" {
  instance = "${aws_instance.drupal-instance.id}"
  vpc      = true
}
