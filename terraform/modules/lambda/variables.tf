variable "lambda_function_name" {
  description = "Lambda function name"
  type        = string
}

variable "sns_topic_arn" {
  description = "SNS topic ARN"
  type        = string
}

variable "environment" {
  description = "Las variables de entorno para la función Lambda"
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "The region where resources will be created"
  type        = string
  default     = "us-west-2" # replace with your default region
}
