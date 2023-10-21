output "sns_topic_arn" {
  value = module.sns.sns_topic_arn
}

output "lambda_function_invoke_arn" {
  value = module.lambda.lambda_function_invoke_arn
}

output "database_name" {
  description = "The name of the database"
  value       = var.database_name
}

output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = var.bucket_name
}
