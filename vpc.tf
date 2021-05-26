# VPC Network
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = "true"
}

# Public Subnet 1
resource "aws_subnet" "main-public-1-a" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = var.AWS_AZ_1_A
}

# Public Subnet 2
resource "aws_subnet" "main-public-1-b" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = var.AWS_AZ_1_B
}

# Private Subnet (There is only 1 private subnet at the moment but can be increased to 2)
resource "aws_subnet" "main-private-1-a" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = var.AWS_AZ_1_A
}
