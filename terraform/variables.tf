variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "database_name" {
  description = "Athena database name"
  type        = string
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "lambda_function_name" {
  description = "Lambda function name"
  type        = string
}

variable "sns_topic_name" {
  description = "SNS topic name"
  type        = string
}

variable "environment" {
  description = "el entorno de la aplicacion"
  type        = string
  default     = "develop"
}

variable "api_name" {
  description = "HTTP API name"
  type        = string
}