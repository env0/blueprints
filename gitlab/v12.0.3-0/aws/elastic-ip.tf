resource "aws_eip" "gitlab-elastic-ip" {
  instance = "${aws_instance.gitlab-instance.id}"
  vpc      = true
}
