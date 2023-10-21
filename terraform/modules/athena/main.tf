resource "aws_athena_database" "challenge" {
  name   = var.database_name
  bucket = var.bucket_name # to store query results
}