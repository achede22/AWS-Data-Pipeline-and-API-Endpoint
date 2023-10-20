resource "aws_ecr_repository" "repository" {
  name                 = var.repository_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}

output "repository_url" {
  description = "The URL of the created ECR repository"
  value       = aws_ecr_repository.repository.repository_url
}
