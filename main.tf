# VPC
module "vpc" {
  source         = "./modules/vpc"
  vpc_cidr       = var.vpc_cidr               
  public_subnets = var.public_subnets  
  private_subnets = var.private_subnets       
  region          = var.region                
  #environment     = var.environment          
}

# SECURITY GROUPS
module "security" {
  source       = "./modules/security"
  vpc_id       = module.vpc.vpc_id            
  #environment  = var.environment             
}

# ECR REPOSITORY

module "ecr" {
  source    = "./modules/ecr"
  repo_name = var.ecr_repo_name
}



module "efs" {
  source          = "./modules/efs"
  subnet_ids      = module.vpc.private_subnets
  efs_sg_id       = module.security.efs_sg
  environment     = var.environment
}


# ECS CLUSTER + TASK + SERVICE
module "ecs" {
  source               = "./modules/ecs"
  cluster_name         = var.cluster_name
  task_image           = var.task_image
  container_port       = var.container_port
  subnet_ids           = module.vpc.private_subnets
  ecs_sg_id            = module.security.ecs_sg
  target_group_arn     = module.alb.target_group_arn
  efs_file_system_id   = module.efs.efs_id
  environment          = var.environment
}


# APPLICATION LOAD BALANCER
module "alb" {
  source              = "./modules/alb"
  vpc_id              = module.vpc.vpc_id              
  public_subnet_ids   = module.vpc.public_subnets       
  alb_sg_id           = module.security.alb_sg          
  #target_group_port   = var.container_port              
  environment         = var.environment               
}
