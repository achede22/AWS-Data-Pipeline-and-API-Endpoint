variable "api_name" {
  description = "HTTP API name"
  type        = string
}

variable "lambda_invoke_arn" {
  description = "The ARN to be used for invoking Lambda Function from API Gateway"
  type        = string
}