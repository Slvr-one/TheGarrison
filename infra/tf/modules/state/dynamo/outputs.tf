
output "s3_dynamo_lock_table" {
  value       = aws_dynamodb_table.tf-state.name
  description = "dynamo name for s3 backent state lock"
}