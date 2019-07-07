resource "aws_eip" "sonarqube-elastic-ip" {
  instance = "${aws_instance.sonarqube-instance.id}"
  vpc      = true
}
