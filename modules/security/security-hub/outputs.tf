#==============================================================================
# SECURITY HUB OUTPUTS
#==============================================================================
output "hub_id" {
  description = "ID of the Security Hub account"
  value       = aws_securityhub_account.this.id
}

output "hub_arn" {
  description = "ARN of the Security Hub account"
  value       = aws_securityhub_account.this.arn
}

output "subscribed_standards" {
  description = "Map of subscribed standard ARNs"
  value       = { for k, v in aws_securityhub_standards_subscription.this : k => v.id }
}
