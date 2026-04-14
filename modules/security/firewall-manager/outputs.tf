#==============================================================================
# FIREWALL MANAGER OUTPUTS
#==============================================================================
output "admin_account_id" {
  description = "ID of the FMS admin account"
  value       = try(aws_fms_admin_account.this[0].id, null)
}

output "policy_ids" {
  description = "Map of policy names to IDs"
  value       = { for k, v in aws_fms_policy.this : k => v.id }
}

output "policy_arns" {
  description = "Map of policy names to ARNs"
  value       = { for k, v in aws_fms_policy.this : k => v.arn }
}
