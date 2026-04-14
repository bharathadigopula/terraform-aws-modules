#==============================================================================
# MACIE OUTPUTS
#==============================================================================
output "account_id" {
  description = "ID of the Macie account"
  value       = aws_macie2_account.this.id
}

output "service_role" {
  description = "Service role ARN used by Macie"
  value       = aws_macie2_account.this.service_role
}

output "classification_job_ids" {
  description = "Map of classification job names to IDs"
  value       = { for k, v in aws_macie2_classification_job.this : k => v.id }
}
