output "bucket_id" {
  value = aws_s3_bucket.tf-state.id
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.tf-state.arn
  description = "The ARN of the S3 bucket"
}
