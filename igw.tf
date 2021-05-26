# Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id
}

# Route Table
resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }
}

# Route Associations for the Public Subnets
resource "aws_route_table_association" "main-public-1-a" {
  subnet_id = aws_subnet.main-public-1-a.id
  route_table_id = aws_route_table.main-public.id
}

resource "aws_route_table_association" "main-public-1-b" {
  subnet_id = aws_subnet.main-public-1-b.id
  route_table_id = aws_route_table.main-public.id
}
