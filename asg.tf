# Creating Launch Template for EC2 instances
resource "aws_launch_template" "app-launch-template" {
  name_prefix   = "app-launch-template"
  image_id      = "ami-087c17d1fe0178315"
  instance_type = "t2.micro"
  key_name      = "new"

  vpc_security_group_ids = [aws_security_group.demosg.id]

  user_data = filebase64("data.sh") # Base64 encoding required for user data in launch template

  tags = {
    Name = "AutoScaledInstance"
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "AutoScaledInstance"
    }
  }
}

# Creating Auto Scaling Group (ASG)
resource "aws_autoscaling_group" "app-asg" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 2
  vpc_zone_identifier  = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]

  launch_template {
    id      = aws_launch_template.app-launch-template.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.target-elb.arn] # Attach to the Target Group of the ALB

  health_check_type         = "ELB"
  health_check_grace_period = 60

  tag {
    key                 = "Name"
    value               = "AutoScaledInstance"
    propagate_at_launch = true
  }

  depends_on = [aws_lb.external-alb]
}

# Optional: Creating Scaling Policies for Auto Scaling Group
# Scale up when CPU utilization exceeds 75%
resource "aws_autoscaling_policy" "scale-up" {
  name                   = "scale-up"
  scaling_adjustment      = 1
  adjustment_type         = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name  = aws_autoscaling_group.app-asg.name

  metric_aggregation_type = "Average"
}

# Scale down when CPU utilization goes below 25%
resource "aws_autoscaling_policy" "scale-down" {
  name                   = "scale-down"
  scaling_adjustment      = -1
  adjustment_type         = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name  = aws_autoscaling_group.app-asg.name

  metric_aggregation_type = "Average"
}

