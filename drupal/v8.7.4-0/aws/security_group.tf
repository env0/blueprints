resource "aws_security_group" "drupal-sg" {
  name        = "drupal-sg"
  description = "Drupal Seciurity group"
  vpc_id      = "${aws_vpc.drupal-vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "drupal-sg"
    CreatedBy = "env0"
  }
}

resource "aws_security_group_rule" "drupal-group-rule-for-https" {
  description              = "Allow HTTPS connection to the drupal instance"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.drupal-sg.id}"
  to_port                  = 443
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "drupal-group-rule-for-http" {
  description              = "Allow HTTP connection to the drupal instance"
  from_port                = 80
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.drupal-sg.id}"
  to_port                  = 80
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "drupal-group-rule-for-ssh" {
  description              = "Allow SSH connection to the drupal instance"
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.drupal-sg.id}"
  to_port                  = 22
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}
