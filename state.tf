#>> uncomment this section only, if the bucket is created!
terraform {
  backend "s3" {
    bucket = "fs80-tf-state"
    key    = "default-infrastructure"
    region = "us-east-1"
  }
}
# <<<