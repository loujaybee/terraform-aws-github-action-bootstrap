provider "aws" {
  version = "~> 2.0"
  region  = "eu-central-1"
}

# terraform {
#   backend "s3" {
#     bucket = "example-terraform-project-name-bootstrap-terraform-state"
#     key    = "default-infrastructure"
#     region = "eu-central-1"
#   }
# }

resource "aws_s3_bucket" "terraform_state" {
  bucket = "example-terraform-project-name-bootstrap-terraform-state"

  versioning {
    enabled = true
  }
}
