provider "aws" {
  region = var.region
}

module "sns" {
  source = "./modules/sns"
  sns_topic_name = var.sns_topic_name
}

module "s3" {
  source = "./modules/s3"
  bucket_name = var.bucket_name
}

module "athena" {
  source      = "./modules/athena"
  bucket_name = var.bucket_name
}

module "lambda" {
  source               = "./modules/lambda"
  lambda_function_name = var.lambda_function_name
  sns_topic_arn        = module.sns.sns_topic_arn
}

module "ecr" {
  source          = "./modules/ecr"
  repository_name = var.repository_name
  scan_on_push    = var.scan_on_push
}
