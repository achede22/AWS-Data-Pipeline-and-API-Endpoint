resource "aws_lambda_function" "challenge" {
  function_name    = var.lambda_function_name
  handler          = "exports.test"
  runtime          = "nodejs12.x"

  role             = aws_iam_role.challenge.arn

  filename         = "/path/to/your/deployment-package.zip"

}

resource "aws_iam_role" "challenge" {
  name               = "${var.lambda_function_name}_execution_role"
  
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

resource "aws_lambda_permission" "challenge" {
  statement_id   = "${var.lambda_function_name}_AllowExecutionFromSNS"
  
  action         = "lambda:InvokeFunction"
  
  function_name  = aws_lambda_function.challenge.function_name
  
  principal      = "sns.amazonaws.com"
  
  source_arn     = var.sns_topic_arn

}
