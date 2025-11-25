variable "cluster_name" {
  type = string
}

variable "task_image" {
  type        = string
  description = "ECR or public image for Nginx"
}

variable "container_port" {
  type        = number
  description = "Container port exposed by the application"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for Fargate tasks"
}

variable "ecs_sg_id" {
  type        = string
  description = "Security Group for ECS tasks"
}

variable "target_group_arn" {
  type        = string
  description = "ALB target group to attach service"
}

variable "efs_file_system_id" {
  type        = string
  description = "EFS to mount in ECS tasks"
}

variable "environment" {
  type = string
}
