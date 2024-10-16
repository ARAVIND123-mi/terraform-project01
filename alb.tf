# Creating External Load Balancer
resource "aws_lb" "external-alb" {
  name               = "External-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.demosg.id]
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]  # Ensure the second subnet is correct
}

# Creating Target Group
resource "aws_lb_target_group" "target-elb" {
  name     = "ALB-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.demovpc.id
}

# Creating Target Group Attachment for the first instance
resource "aws_lb_target_group_attachment" "attachment1" {
  target_group_arn = aws_lb_target_group.target-elb.arn
  target_id        = aws_instance.demonistance[0].id
  port             = 80

  depends_on = [
    aws_lb_target_group.target-elb,
    aws_instance.demonistance,
  ]
}

# Creating Target Group Attachment for the second instance
resource "aws_lb_target_group_attachment" "attachment2" {
  target_group_arn = aws_lb_target_group.target-elb.arn
  target_id        = aws_instance.demonistance1[0].id
  port             = 80

  depends_on = [
    aws_lb_target_group.target-elb,
    aws_instance.demonistance1,
  ]
}

# Creating Load Balancer Listener
resource "aws_lb_listener" "external-elb" {
  load_balancer_arn = aws_lb.external-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-elb.arn
  }
}

