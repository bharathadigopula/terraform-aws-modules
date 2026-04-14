#==============================================================================
# SECURITY LAKE OUTPUTS
#==============================================================================
output "data_lake_arn" {
  description = "ARN of the Security Lake data lake"
  value       = aws_securitylake_data_lake.this.arn
}

output "s3_bucket_arn" {
  description = "S3 bucket ARN used by Security Lake"
  value       = aws_securitylake_data_lake.this.s3_bucket_arn
}

output "subscriber_arns" {
  description = "Map of subscriber names to ARNs"
  value       = { for k, v in aws_securitylake_subscriber.this : k => v.arn }
}
