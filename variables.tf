variable "region" {
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  default     = "sandbox"
}

variable "vpc_cidr" {
  type        = string
}

variable "public_subnets" {
  type        = list(string)
}

# ECS Variables
variable "cluster_name" {
  type        = string
  default     = "ecs-sandbox"
}

variable "task_image" {
  type        = string
  description = "Docker image for ECS task"
}

variable "container_port" {
  type        = number
  default     = 80
}

# ECR
variable "ecr_repo_name" {
  type        = string
  default     = "nginx-app"
}

variable "private_subnets" {
  type        = list(string)
  description = "CIDRs for private subnets"
}
