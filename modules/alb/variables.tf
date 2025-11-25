variable "vpc_id" {
  type        = string
  description = "VPC ID for ALB"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Public subnets for ALB"
}

variable "alb_sg_id" {
  type        = string
  description = "Security group assigned to the ALB"
}

variable "environment" {
  type = string
}
