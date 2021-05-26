# ECS Launch Configuration
resource "aws_launch_configuration" "ecs-lanuchconfig" {
  name_prefix = "ecs-lanuchconfig"
  image_id = var.ECS_AMI
  instance_type = var.ECS_INSTANCE_TYPE
  iam_instance_profile = aws_iam_instance_profile.ecs-ec2-role-profile.id
  security_groups = [
    aws_security_group.ecs-sg.id
  ]
  user_data = "#!/bin/bash\necho 'ECS_CLUSTER=ecs-cluster' > /etc/ecs/ecs.config\nstart ecs"

  lifecycle {
    create_before_destroy = true
  }
}

# ECS Autoscaling Group
resource "aws_autoscaling_group" "ecs-autoscaling" {
  name = "ecs-autoscaling"
  vpc_zone_identifier = [
    aws_subnet.main-private-1-a.id
  ]
  launch_configuration = aws_launch_configuration.ecs-lanuchconfig.name
  min_size = 1
  max_size = 2
  desired_capacity = 2
  health_check_grace_period = 60
  health_check_type = "EC2"
  force_delete = true
}

# ECS Scale Up Policy
resource "aws_autoscaling_policy" "ecs-scale-up" {
  name = "ecs-scale-up"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 120
  autoscaling_group_name = aws_autoscaling_group.ecs-autoscaling.name
}

# ECS Scale Down Policy
resource "aws_autoscaling_policy" "ecs-scale-down" {
  name = "ecs-scale-down"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 120
  autoscaling_group_name = aws_autoscaling_group.ecs-autoscaling.name
}
