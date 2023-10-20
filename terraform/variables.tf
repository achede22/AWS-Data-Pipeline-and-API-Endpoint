variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
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

### ECR
variable "repository_name" {
  description = "The name of the repository"
  type        = string
}

variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not (false)"
  type        = bool
  default     = true
}