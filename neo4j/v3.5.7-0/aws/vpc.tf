#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "neo4j-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
      Name = "neo4j-vpc-${random_uuid.uuid.result}",
      CreatedBy= "env0"
  }
}

resource "aws_subnet" "neo4j-subnet" {
  count = 1
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = "${aws_vpc.neo4j-vpc.id}"

  tags = {
      Name = "neo4j-subnet-${random_uuid.uuid.result}",
      CreatedBy = "env0"
  }
}

resource "aws_internet_gateway" "neo4j-ig" {
  vpc_id = "${aws_vpc.neo4j-vpc.id}"

  tags = {
    Name = "neo4j-internet-gateway-${random_uuid.uuid.result}",
    CreatedBy = "env0"
  }
}

resource "aws_route_table" "neo4j-rt" {
  vpc_id = "${aws_vpc.neo4j-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.neo4j-ig.id}"
  }

  tags = {
    Name = "neo4j-routing-table-${random_uuid.uuid.result}",
    CreatedBy = "env0"
  }
}

resource "aws_route_table_association" "neo4j-rt-association" {
  count = 1
  subnet_id      = "${aws_subnet.neo4j-subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.neo4j-rt.id}"
}
