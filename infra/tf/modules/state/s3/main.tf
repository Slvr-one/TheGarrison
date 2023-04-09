locals {
  bucket_name = "dvir-terraform-state"

}

#S3 state bucket--
resource "aws_s3_bucket" "tf-state" {
  bucket = local.bucket_name

  # object_lock_configuration {
  #   object_lock_enabled = "Enabled"

  #   rule {
  #     default_retention {
  #       mode = "COMPLIANCE"
  #       days = 5
  #     }
  #   }
  # }

  # lifecycle {
  #   prevent_destroy = true
  # }
}


resource "aws_s3_bucket_acl" "tf-state_bucket_acl" {
  bucket = aws_s3_bucket.tf-state.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "tf-state_bucket_ver" {
  bucket = aws_s3_bucket.tf-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf-state_bucket_sse_config" {
  bucket = aws_s3_bucket.tf-state.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_master_key_id
      sse_algorithm     = "aws:kms"
      # sse_algorithm = "AES256"
    }
  }
}

#public access block to tf state--
resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.tf-state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# resource "aws_s3_bucket_acl" "tfstate" {
#   bucket = aws_s3_bucket.tfstate.id
#   acl    = "private"
# }
