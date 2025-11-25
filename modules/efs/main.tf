resource "aws_efs_file_system" "this" {
  creation_token = "efs-${var.environment}"
  
  tags = {
    Name        = "efs-${var.environment}"
    Environment = var.environment
  }
}

# Create mount targets in each subnet
resource "aws_efs_mount_target" "this" {
  count = length(var.subnet_ids)

  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = var.subnet_ids[count.index]
  security_groups = [var.efs_sg_id]    # Allow NFS from ECS tasks

}
