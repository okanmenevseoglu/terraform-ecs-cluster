# Elastic IP to be used by NAT GW 1
resource "aws_eip" "nat-ip-1-a" {
  vpc = true
}

# Elastic IP to be used by NAT GW 2
resource "aws_eip" "nat-ip-1-b" {
  vpc = true
}

# Nat GW 1
resource "aws_nat_gateway" "nat-gw-1-a" {
  allocation_id = aws_eip.nat-ip-1-a.id
  subnet_id = aws_subnet.main-public-1-a.id
}

# Nat GW 2
resource "aws_nat_gateway" "nat-gw-1-b" {
  allocation_id = aws_eip.nat-ip-1-b.id
  subnet_id = aws_subnet.main-public-1-b.id
}

# VPC Setup for NAT GW 1
resource "aws_route_table" "main-private-1-a" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-1-a.id
  }
}

# VPC Setup for NAT GW 2
resource "aws_route_table" "main-private-1-b" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-1-b.id
  }
}

# Route Associations for NAT GW 1
resource "aws_route_table_association" "main-private-1-a" {
  subnet_id = aws_subnet.main-private-1-a.id
  route_table_id = aws_route_table.main-private-1-a.id
}


# Route Associations for NAT GW 2
resource "aws_route_table_association" "main-private-1-b" {
  subnet_id = aws_subnet.main-private-1-a.id
  route_table_id = aws_route_table.main-private-1-b.id
}
