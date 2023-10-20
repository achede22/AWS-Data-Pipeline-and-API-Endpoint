output "sns_topic_arn" {
  value = module.sns.sns_topic_arn
}

output "lambda_function_invoke_arn" {
  value = module.lambda.lambda_function_invoke_arn
}
