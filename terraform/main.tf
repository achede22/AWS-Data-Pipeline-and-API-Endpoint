provider "aws" {
  region = var.region
}

module "sns" {
  source         = "./modules/sns"
  sns_topic_name = var.sns_topic_name
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
}

module "athena" {
  source        = "./modules/athena"
  database_name = var.database_name
  bucket_name   = var.bucket_name
}

module "lambda" {
  source               = "./modules/lambda"
  lambda_function_name = var.lambda_function_name
  sns_topic_arn        = module.sns.sns_topic_arn
  database_name        = var.database_name
  bucket_name          = var.bucket_name
  environment = {
    SNS_TOPIC_ARN = module.sns.sns_topic_arn
  }

}

module "api_gateway" {
  source                         = "./modules/api_gateway"
  api_name                       = var.api_name
  lambda_invoke_arn              = module.lambda.lambda_function_invoke_arn
}
