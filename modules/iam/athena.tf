resource "aws_iam_policy" "athena_s3_access" {
  name        = "AthenaS3Access"
  description = "Allow Athena to access S3 buckets"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetBucketLocation",
        "s3:GetObject",
        "s3:ListBucket",
        "s3:ListBucketMultipartUploads",
        "s3:ListMultipartUploadParts",
        "s3:AbortMultipartUpload",
        "s3:CreateBucket",
        "s3:PutObject"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "athena_s3_access" {
  role       = aws_iam_role.athena_role.name
  policy_arn = aws_iam_policy.athena_s3_access.arn
}