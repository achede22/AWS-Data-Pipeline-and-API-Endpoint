terraform {
  backend "s3" {
    bucket = "challenge-terraform-state"
    key    = "challenge/terraform.tfstate"
    region = "us-west-2"
    access_key = "${var.AWS_ACCESS_KEY_ID}"
    secret_key = "${var.AWS_SECRET_ACCESS_KEY}"
  }
}