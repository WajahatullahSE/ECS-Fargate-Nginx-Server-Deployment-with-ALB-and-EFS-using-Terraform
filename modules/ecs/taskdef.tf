
# ECS Task Definition

resource "aws_ecs_task_definition" "this" {
  family                   = "nginx-${var.environment}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "nginx-custom"
      image = "504649076991.dkr.ecr.us-east-1.amazonaws.com/ngin-app:latest"
      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]

      mountPoints = [
        {
          containerPath = "/mnt/efs"
          sourceVolume  = "shared_data"
        }
      ]
    }
  ])

  volume {
    name = "shared_data"
    efs_volume_configuration {
      file_system_id = var.efs_file_system_id
      root_directory = "/"
    }
  }

  tags = {
    Name        = "nginx-task-${var.environment}"
    Environment = var.environment
  }
}
