#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "elk-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
      Name = "elk-vpc-${random_uuid.uuid.result}",
      CreatedBy= "env0"
  }
}

resource "aws_subnet" "elk-subnet" {
  count = 1
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = "${aws_vpc.elk-vpc.id}"

  tags = {
      Name = "elk-subnet-${random_uuid.uuid.result}",
      CreatedBy = "env0"
  }
}

resource "aws_internet_gateway" "elk-ig" {
  vpc_id = "${aws_vpc.elk-vpc.id}"

  tags = {
    Name = "elk-internet-gateway-${random_uuid.uuid.result}",
    CreatedBy = "env0"
  }
}

resource "aws_route_table" "elk-rt" {
  vpc_id = "${aws_vpc.elk-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.elk-ig.id}"
  }

  tags = {
    Name = "elk-routing-table-${random_uuid.uuid.result}",
    CreatedBy = "env0"
  }
}

resource "aws_route_table_association" "elk-rt-association" {
  count = 1
  subnet_id      = "${aws_subnet.elk-subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.elk-rt.id}"
}
