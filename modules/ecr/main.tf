resource "aws_ecr_repository" "this" {
  name = var.repo_name
  tags = { Name = var.repo_name }

}
