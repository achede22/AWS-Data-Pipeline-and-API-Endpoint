resource "aws_athena_database" "challenge" {
  name   = var.bucket_name
  bucket = var.bucket_name
}
