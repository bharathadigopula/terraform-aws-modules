#==============================================================================
# S3 REPLICATION CONFIGURATION OUTPUTS
#==============================================================================
output "replication_configuration_role" {
  description = "ARN of the IAM role associated with the replication configuration"
  value       = aws_s3_bucket_replication_configuration.this.role
}

output "replication_rule_ids" {
  description = "List of replication rule IDs"
  value       = [for rule in aws_s3_bucket_replication_configuration.this.rule : rule.id]
}
