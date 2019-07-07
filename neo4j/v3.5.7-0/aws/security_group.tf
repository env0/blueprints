resource "aws_security_group" "neo4j-sg" {
  name        = "neo4j-sg"
  description = "neo4j Seciurity group"
  vpc_id      = "${aws_vpc.neo4j-vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "neo4j-sg"
    CreatedBy = "env0"
  }
}

resource "aws_security_group_rule" "neo4j-group-rule-for-ports-1" {
  description              = "Allow ports connection to the neo4j instance"
  from_port                = 7473
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.neo4j-sg.id}"
  to_port                  = 7474
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "neo4j-group-rule-for-ports-2" {
  description              = "Allow ports connection to the neo4j instance"
  from_port                = 7687
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.neo4j-sg.id}"
  to_port                  = 7687
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "neo4j-group-rule-for-ssh" {
  description              = "Allow SSH connection to the neo4j instance"
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.neo4j-sg.id}"
  to_port                  = 22
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}
