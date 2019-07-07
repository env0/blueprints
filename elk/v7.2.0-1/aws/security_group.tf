resource "aws_security_group" "elk-sg" {
  name        = "elk-sg"
  description = "ELK Seciurity group"
  vpc_id      = "${aws_vpc.elk-vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elk-sg"
    CreatedBy = "env0"
  }
}

resource "aws_security_group_rule" "elk-group-rule-for-https" {
  description              = "Allow HTTPS connection to the elk instance"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.elk-sg.id}"
  to_port                  = 443
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "elk-group-rule-for-http" {
  description              = "Allow HTTP connection to the elk instance"
  from_port                = 80
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.elk-sg.id}"
  to_port                  = 80
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "elk-group-rule-for-ssh" {
  description              = "Allow SSH connection to the elk instance"
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.elk-sg.id}"
  to_port                  = 22
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}
