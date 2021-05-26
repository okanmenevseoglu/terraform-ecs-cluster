# Application Load Balancer
resource "aws_alb" "ecs-alb" {
  name = "ecs-alb"
  subnets = [
    aws_subnet.main-public-1-a.id,
    aws_subnet.main-public-1-b.id
  ]
  security_groups = [
    aws_security_group.alb-sg.id
  ]
}

# ALB Target Group
resource "aws_alb_target_group" "ecs-alb-tg" {
  name = "ecs-alb-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id
}

# ALB Listener for the Target Group
resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.ecs-alb.id
  port = 80
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.ecs-alb-tg.id
    type = "forward"
  }
}
