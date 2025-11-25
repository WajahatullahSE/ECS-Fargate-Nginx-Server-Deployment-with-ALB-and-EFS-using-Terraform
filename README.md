# ECS-Fargate-Nginx-Server-Deployment-with-ALB-and-EFS-using-Terraform
## Overview
This project deploys a fully managed container workload using ECS Fargate, an Application Load Balancer, persistent storage via EFS, a custom NGINX image stored in ECR, and a modular Terraform setup.

The workflow:
1. Build and push a custom NGINX Docker image to ECR.
2. Deploy infrastructure using Terraform.
3. ECS pulls the image and runs it behind an ALB.
4. EFS provides persistent storage for the application.

## Architecture Diagram
```markdown
![Architecture Diagram](./doc/ecs-alb-nginx-tr-1.png)
```
---

## Prerequisites
- AWS CLI configured (`aws configure`)
- Terraform installed
- Docker installed
- Existing S3 bucket for remote Terraform backend
- ECR repository created (Terraform can also create it)

---

## Project Deployment

### Initialize Terraform
```bash
terraform init
```

### Validate
```bash
terraform validate
```

### Plan
```bash
terraform plan
```

### Apply
```bash
terraform apply
```

This provisions:
- VPC, subnets and routing
- ALB
- ECS Fargate cluster and service
- Task definition with container configuration
- EFS
- Security groups and IAM policies

---

# Custom NGINX Image

This section describes how to build, tag and push a simple custom NGINX image that ECS will run.

## Create Files

### `Dockerfile`
```dockerfile
FROM nginx:latest
COPY ./index.html /usr/share/nginx/html/index.html
```

### `index.html`
```html
<!DOCTYPE html>
<html>
<head>
    <title>Custom NGINX on ECS</title>
</head>
<body>
    <h1>NGINX on ECS Fargate with EFS</h1>
</body>
</html>
```

---

# Build and Push to ECR

### 1. Authenticate Docker to ECR
```bash
aws ecr get-login-password --region us-west-2 \
| docker login --username AWS --password-stdin <aws-account-id>.dkr.ecr.us-west-2.amazonaws.com
```

### 2. Build Image
```bash
docker build -t nginx-custom .
```

### 3. Tag Image
```bash
docker tag nginx-custom:latest <aws-account-id>.dkr.ecr.us-west-2.amazonaws.com/nginx-custom:latest
```

### 4. Push to ECR
```bash
docker push <aws-account-id>.dkr.ecr.us-west-2.amazonaws.com/nginx-custom:latest
```

---

# Updating ECS After New Image

If you push a new image:
1. Update the ECS task definition to reference the latest image URI.
2. Register a new revision.
3. Deploy the ECS service again.

ECS will replace old tasks with new ones automatically.

---

# Destroying the Infrastructure
```bash
terraform destroy
```

Terraform will remove all provisioned infrastructure.

---

# Notes
- Update the task definition image URI each time a new image is pushed.
- Ensure ALB health check path and security groups allow traffic correctly.
- EFS mount points must exist before ECS service starts.

---
