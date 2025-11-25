variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR range"
}

variable "public_subnets" {
  type        = list(string)
  description = "CIDRs for public subnets"
}

variable "region" {
  type        = string
}

variable "private_subnets" {
  type        = list(string)
  description = "CIDRs for private subnets"
}

