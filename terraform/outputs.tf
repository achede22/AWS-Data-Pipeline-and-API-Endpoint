output "sns_topic_arn" {
  value = module.sns.sns_topic_arn
}

output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = module.ecr.repository_url
}

