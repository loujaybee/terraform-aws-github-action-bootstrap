provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "example-terraform-project-name-bootstrap-terraform-state"
    key    = "default-infrastructure"
    region = "us-east-1"
  }
}


resource "aws_s3_bucket" "terraform_state_2" {
  bucket = "example-terraform-project-name-bootstrap-terraform-state-2"

  versioning {
    enabled = true
  }
}
