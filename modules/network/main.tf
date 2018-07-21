# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = false

  tags {
    Environment = "${var.environment}"
  }
}

# Create public subnets
resource "aws_subnet" "pub_subnets" {
  count             = "${length(var.subnets)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${element(var.subnets, count.index)}"
  availability_zone = "${element(var.az, count.index)}"

  tags {
    Environment = "${var.environment}"
  }
}

# Create IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Environment = "${var.environment}"
  }
}

# Create the public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Environment = "${var.environment}"
  }
}

# Associate public subnets to public route table
resource "aws_route_table_association" "public_subnet_association" {
  count          = "${length(var.subnets)}"
  subnet_id      = "${element(aws_subnet.pub_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}
