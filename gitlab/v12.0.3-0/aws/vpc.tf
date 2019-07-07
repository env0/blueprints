#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "gitlab-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
      Name = "gitlab-vpc-${random_uuid.uuid.result}",
      CreatedBy= "env0"
  }
}

resource "aws_subnet" "gitlab-subnet" {
  count = 1
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = "${aws_vpc.gitlab-vpc.id}"

  tags = {
      Name = "gitlab-subnet-${random_uuid.uuid.result}",
      CreatedBy = "env0"
  }
}

resource "aws_internet_gateway" "gitlab-ig" {
  vpc_id = "${aws_vpc.gitlab-vpc.id}"

  tags = {
    Name = "gitlab-internet-gateway-${random_uuid.uuid.result}",
    CreatedBy = "env0"
  }
}

resource "aws_route_table" "gitlab-rt" {
  vpc_id = "${aws_vpc.gitlab-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gitlab-ig.id}"
  }

  tags = {
    Name = "gitlab-routing-table-${random_uuid.uuid.result}",
    CreatedBy = "env0"
  }
}

resource "aws_route_table_association" "gitlab-rt-association" {
  count = 1
  subnet_id      = "${aws_subnet.gitlab-subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.gitlab-rt.id}"
}
