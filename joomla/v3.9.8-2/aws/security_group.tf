resource "aws_security_group" "joomla-sg" {
  name        = "joomla-sg"
  description = "Joomla Seciurity group"
  vpc_id      = "${aws_vpc.joomla-vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "joomla-sg"
    CreatedBy = "env0"
  }
}

resource "aws_security_group_rule" "joomla-group-rule-for-https" {
  description              = "Allow HTTPS connection to the joomla instance"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.joomla-sg.id}"
  to_port                  = 443
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "joomla-group-rule-for-http" {
  description              = "Allow HTTP connection to the joomla instance"
  from_port                = 80
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.joomla-sg.id}"
  to_port                  = 80
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "joomla-group-rule-for-ssh" {
  description              = "Allow SSH connection to the joomla instance"
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.joomla-sg.id}"
  to_port                  = 22
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}
