resource "aws_vpc" "default" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = merge({ Name = "default-vpc" }, var.tags)
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.default.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.2.0/24"

  tags = merge({ Name = "private-subnet" }, var.tags)
}

resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.default.id
  cidr_block              = cidrsubnet(aws_vpc.default.cidr_block, 8, count.index)
  availability_zone       = element(["us-east-1a", "us-east-1b"], count.index)
  map_public_ip_on_launch = true
  tags                    = merge({ Name = "public-subnet-${count.index}" }, var.tags)
}

resource "aws_internet_gateway" "default_igw" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "default-igw"
  }
}

resource "aws_route_table" "default_rtb" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default_igw.id
  }

  tags = {
    Name = "default-route-table"
  }
}

resource "aws_route_table_association" "rta_public" {
  count          = 2
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.default_rtb.id
}

resource "aws_route_table_association" "rta_private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.default_rtb.id
}