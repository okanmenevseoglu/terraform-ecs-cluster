# ECS Cluster
resource "aws_ecs_cluster" "ecs-cluster" {
  name = "ecs-cluster"
}

# Task Definition Template
data "template_file" "nginx-task-definition-template" {
  template = file("templates/nginx-task-definition.json.tpl")
}

# Task Definition
resource "aws_ecs_task_definition" "ecs-cluster-task-definition" {
  family = "nginx-task"
  container_definitions = data.template_file.nginx-task-definition-template.rendered
}

# Service Definition
resource "aws_ecs_service" "nginx-service" {
  name = "nginx-service"
  cluster = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.ecs-cluster-task-definition.arn
  desired_count = 2
  depends_on = [
    aws_iam_policy_attachment.ecs-service-policy-attachment,
    aws_alb_listener.alb_listener
  ]

  load_balancer {
    target_group_arn = aws_alb_target_group.ecs-alb-tg.arn
    container_name = "nginx-container"
    container_port = 80
  }
}
