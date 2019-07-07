resource "aws_security_group" "sonarqube-sg" {
  name        = "sonarqube-sg"
  description = "SonarQube Seciurity group"
  vpc_id      = "${aws_vpc.sonarqube-vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sonarqube-sg"
    CreatedBy = "env0"
  }
}

resource "aws_security_group_rule" "sonarqube-group-rule-for-https" {
  description              = "Allow HTTPS connection to the sonarqube instance"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.sonarqube-sg.id}"
  to_port                  = 443
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "sonarqube-group-rule-for-http" {
  description              = "Allow HTTP connection to the sonarqube instance"
  from_port                = 80
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.sonarqube-sg.id}"
  to_port                  = 80
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "sonarqube-group-rule-for-ssh" {
  description              = "Allow SSH connection to the sonarqube instance"
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.sonarqube-sg.id}"
  to_port                  = 22
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}
