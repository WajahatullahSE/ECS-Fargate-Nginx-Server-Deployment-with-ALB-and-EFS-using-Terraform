# ALB Security Group
resource "aws_security_group" "alb_sg" {
  name        = "sandbox-alb-sg"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "sandbox-alb-sg"
    Project     = "nginx-fargate"
    Environment = "sandbox"
    ManagedBy   = "Terraform"
  }
}


# ECS Task Security Group

resource "aws_security_group" "ecs_sg" {
  name        = "sandbox-ecs-sg"
  description = "Security group for ECS tasks"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow traffic from ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [
      aws_security_group.alb_sg.id
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "sandbox-ecs-sg"
    Project     = "nginx-fargate"
    Environment = "sandbox"
    ManagedBy   = "Terraform"
  }
}


# EFS Security Group

resource "aws_security_group" "efs_sg" {
  name        = "sandbox-efs-sg"
  description = "Security group for EFS"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow NFS from ECS"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    security_groups = [
      aws_security_group.ecs_sg.id
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "sandbox-efs-sg"
    Project     = "nginx-fargate"
    Environment = "sandbox"
    ManagedBy   = "Terraform"
  }
}
