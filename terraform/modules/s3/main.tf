resource "aws_s3_bucket" "challenge" {
  bucket = var.bucket_name
}

# resource "aws_s3_bucket_acl" "challenge" {
#   bucket = var.bucket_name
#   acl    = "private"
# }
