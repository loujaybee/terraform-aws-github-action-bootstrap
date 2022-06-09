terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

#>> uncomment this section only, if the bucket is created!
terraform {
  backend "s3" {
    bucket = "fs80-tf-state"
    key    = "default-infrastructure"
    region = "us-east-1"
  }
}
# <<<
