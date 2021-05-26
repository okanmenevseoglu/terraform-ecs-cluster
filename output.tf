# Outputs the public DNS name to access the ALB and NGINX
output "alb" {
  value = aws_alb.ecs-alb.dns_name
}
