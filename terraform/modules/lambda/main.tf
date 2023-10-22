resource "aws_lambda_function" "challenge" {
  function_name = var.lambda_function_name
  filename      = "deployment-package.zip"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  timeout       = 300 #athena can take a while to run

  role = aws_iam_role.challenge.arn

# python uses these variables inside Lambda function
  environment {
    variables = {
      DATABASE_NAME = var.database_name
      BUCKET_NAME = var.bucket_name
      SNS_TOPIC_ARN = var.sns_topic_arn
    }
  }
}

resource "aws_lambda_alias" "this" {
  name             = "challenge"
  description      = "Challenge DevSecOps/SRE" 
  function_name    = aws_lambda_function.challenge.function_name
  function_version = "$LATEST"
}

resource "aws_iam_role" "challenge" {
  name = "${var.lambda_function_name}_execution_role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": ["sts:AssumeRole"],
            "Effect": "allow",
            "Principal": {"Service": ["lambda.amazonaws.com"]}
        }
    ]
}
EOF

}