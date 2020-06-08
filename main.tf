provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-state-file1"
    key    = "default-infrastructure"
    region = "us-east-1"
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-file1"

  versioning {
    enabled = true
  }
}
