#?: https://angelo-malatacca83.medium.com/aws-terraform-s3-and-dynamodb-backend-3b28431a76c1

#^ bucket creation
resource "aws_s3_bucket" "terraform_state" {
  bucket = "fs80-tf-state"

}

#^ bucket configuration
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.terraform_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      /* kms_master_key_id = aws_kms_key.mykey.arn */
      sse_algorithm     = "AES256"
    }
  }
}

resource "aws_s3_bucket_object_lock_configuration" "object_lock" {
  bucket = aws_s3_bucket.terraform_state.bucket

  rule {
    default_retention {
      mode = "COMPLIANCE"
      days = 5
    }
  }
}

#^ dynamo db
resource "aws_dynamodb_table" "terraform-lock" {
  name           = "terraform_state"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    "Name" = "DynamoDB Terraform State Lock Table"
  }
}
