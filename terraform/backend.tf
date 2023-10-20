terraform {
  backend "s3" {
    bucket = "challenge-terraform-state"
    key = "challenge/terraform.tfstate"
    region = "us-west-2"
  }
}
