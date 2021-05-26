# Security Group for the ECS cluster
# For 2 parallel tasks, we need dynamic port mapping. The default ephemeral port range is 32768 to 65535 inclusive.
# We define this range as an ingress for our public subnets
resource "aws_security_group" "ecs-sg" {
  vpc_id = aws_vpc.main.id
  name = "ecs-sg"
  description = "security group for ecs"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  ingress {
    from_port = 32768
    to_port = 65535
    protocol = "TCP"
    cidr_blocks = [
      "10.0.1.0/24",
      "10.0.3.0/24"
    ]
  }
}

# Security Group for the Application Load Balancer
# Enable port 80 for ingress as the standard HTTP access
resource "aws_security_group" "alb-sg" {
  vpc_id = aws_vpc.main.id
  name = "alb-sg"
  description = "security group for alb"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "TCP"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}
