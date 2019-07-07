#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "wordpress-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
      Name = "wordpress-vpc-${random_uuid.uuid.result}",
      CreatedBy= "env0"
  }
}

resource "aws_subnet" "wordpress-subnet" {
  count = 1
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = "${aws_vpc.wordpress-vpc.id}"

  tags = {
      Name = "wordpress-subnet-${random_uuid.uuid.result}",
      CreatedBy = "env0"
  }
}

resource "aws_internet_gateway" "wordpress-ig" {
  vpc_id = "${aws_vpc.wordpress-vpc.id}"

  tags = {
    Name = "wordpress-internet-gateway-${random_uuid.uuid.result}",
    CreatedBy = "env0"
  }
}

resource "aws_route_table" "wordpress-rt" {
  vpc_id = "${aws_vpc.wordpress-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.wordpress-ig.id}"
  }

  tags = {
    Name = "wordpress-routing-table-${random_uuid.uuid.result}",
    CreatedBy = "env0"
  }
}

resource "aws_route_table_association" "wordpress-rt-association" {
  count = 1
  subnet_id      = "${aws_subnet.wordpress-subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.wordpress-rt.id}"
}
