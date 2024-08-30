# Define the AWS provider and specify the region where resources will be deployed
provider "aws" {
  region = var.region
}

# Module for SNS (Simple Notification Service) configuration
# This module sets up an SNS topic to allow a Pub/Sub scheme
module "sns" {
  source         = "./modules/sns"          # Path to the SNS module
  sns_topic_name = var.sns_topic_name       # Name of the SNS topic
}

# Module for S3 bucket configuration
# This module creates an S3 bucket for storing the DataLake data
module "s3" {
  source      = "./modules/s3"              # Path to the S3 module
  bucket_name = var.bucket_name             # Name of the S3 bucket
}

# Module for Athena configuration
# This module creates an Athena database to execute SQL queries on the data in the S3 bucket
module "athena" {
  source        = "./modules/athena"        # Path to the Athena module
  database_name = var.database_name         # Name of the Athena database
  bucket_name   = var.bucket_name           # Name of the S3 bucket where data is stored
}

# Module for Lambda configuration
# This module sets up a Lambda function that interacts with SNS and Athena
module "lambda" {
  source               = "./modules/lambda" # Path to the Lambda module
  lambda_function_name = var.lambda_function_name # Name of the Lambda function
  sns_topic_arn        = module.sns.sns_topic_arn # ARN of the SNS topic
  database_name        = var.database_name        # Name of the Athena database
  bucket_name          = var.bucket_name          # Name of the S3 bucket

  # Environment variables for the Lambda function
  environment = {
    SNS_TOPIC_ARN = module.sns.sns_topic_arn
  }
}

# Module for API Gateway configuration
# This module creates an API Gateway that invokes the Lambda function
module "api_gateway" {
  source                         = "./modules/api_gateway"  # Path to the API Gateway module
  api_name                       = var.api_name             # Name of the API
  lambda_invoke_arn              = module.lambda.lambda_function_invoke_arn # Invoke ARN of the Lambda function
}
