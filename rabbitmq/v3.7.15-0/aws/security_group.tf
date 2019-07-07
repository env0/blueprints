resource "aws_security_group" "rabbitmq-sg" {
  name        = "rabbitmq-sg"
  description = "RabbitMQ Seciurity group"
  vpc_id      = "${aws_vpc.rabbitmq-vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rabbitmq-sg"
    CreatedBy = "env0"
  }
}

resource "aws_security_group_rule" "rabbitmq-group-rule-for-https" {
  description              = "Allow HTTPS connection to the rabbitmq instance"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.rabbitmq-sg.id}"
  to_port                  = 443
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "rabbitmq-group-rule-for-http" {
  description              = "Allow HTTP connection to the rabbitmq instance"
  from_port                = 80
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.rabbitmq-sg.id}"
  to_port                  = 80
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}


resource "aws_security_group_rule" "rabbitmq-group-rule-for-admin-http" {
  description              = "Allow admin port connection to the rabbitmq instance"
  from_port                = 5672
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.rabbitmq-sg.id}"
  to_port                  = 5672
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}


resource "aws_security_group_rule" "rabbitmq-group-rule-for-admin-page-http" {
  description              = "Allow admin port connection to the rabbitmq instance"
  from_port                = 15672
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.rabbitmq-sg.id}"
  to_port                  = 15672
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "rabbitmq-group-rule-for-ssh" {
  description              = "Allow SSH connection to the rabbitmq instance"
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.rabbitmq-sg.id}"
  to_port                  = 22
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}
