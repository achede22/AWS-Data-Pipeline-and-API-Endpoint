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

resource "aws_iam_role_policy" "challenge" {
  name = "${var.lambda_function_name}_execution_policy"
  role = aws_iam_role.challenge.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
                "athena:StartQueryExecution",
                "athena:GetQueryExecution",
                "athena:GetQueryResults",
                "glue:GetTable"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": [
                "sns:Publish"
            ],
            "Effect": "Allow",
            "Resource": "${aws_sns_topic.challenge.arn}"
        },
        {
            "Action": [
                "s3:*"
            ],
            "Effect": "Allow",
            "Resource": "${aws_s3_bucket.challenge.arn}"
        }
    ]
}
EOF

}


athena start query execution
get query execution
get query result
glue get table