resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
}

resource "aws_subnet" "subnet_a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.subnet_a_cidr_block
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = var.public_associate_public_ip

  tags = {
    Name = "kubernetes.io/cluster/project-cluster"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.subnet_b_cidr_block
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = var.private_associate_public_ip
}

resource "aws_subnet" "subnet_c" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.subnet_c_cidr_block
  availability_zone = "eu-west-1b"
  map_public_ip_on_launch = var.private_associate_public_ip
}

resource "aws_subnet" "subnet_d" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.subnet_d_cidr_block
  availability_zone = "eu-west-1b"
  map_public_ip_on_launch = var.public_associate_public_ip

  tags = {
    Name = "kubernetes.io/cluster/project-cluster"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.open_internet
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rt_association" {
  subnet_id = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.open_internet
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rt_association2" {
  subnet_id = aws_subnet.subnet_d.id
  route_table_id = aws_route_table.rt2.id
}




