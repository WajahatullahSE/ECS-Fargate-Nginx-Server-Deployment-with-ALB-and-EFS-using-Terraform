
# Application Load Balancer

resource "aws_lb" "this" {
  name               = "alb-${var.environment}"
  load_balancer_type = "application"
  internal           = false                       # Public ALB
  subnets            = var.public_subnet_ids
  security_groups    = [var.alb_sg_id]

  tags = {
    Name        = "alb-${var.environment}"
    Environment = var.environment
  }
}


# Target Group for ECS
# ECS tasks will register here automatically
resource "aws_lb_target_group" "this" {
  name        = "tg-${var.environment}"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"               # Required for Fargate
  vpc_id      = var.vpc_id

  health_check {
    protocol = "HTTP"
    path     = "/index.html"                 # Health check endpoint
    interval = 30
    timeout  = 5
  }

  tags = {
    Name        = "tg-${var.environment}"
    Environment = var.environment
  }
}


# Listener (HTTP 80) that forwards to target group
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
