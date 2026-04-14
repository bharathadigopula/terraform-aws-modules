#==============================================================================
# KMS KEY OUTPUTS
#==============================================================================
output "key_id" {
  description = "ID of the KMS key"
  value       = aws_kms_key.this.key_id
}

output "key_arn" {
  description = "ARN of the KMS key"
  value       = aws_kms_key.this.arn
}

output "alias_arns" {
  description = "Map of alias names to ARNs"
  value       = { for k, v in aws_kms_alias.this : k => v.arn }
}
