#==============================================================================
# ORGANIZATION OUTPUTS
#==============================================================================
output "organization_id" {
  description = "ID of the organization"
  value       = try(aws_organizations_organization.this[0].id, null)
}

output "organization_arn" {
  description = "ARN of the organization"
  value       = try(aws_organizations_organization.this[0].arn, null)
}

output "root_id" {
  description = "ID of the organization root"
  value       = try(aws_organizations_organization.this[0].roots[0].id, null)
}

#==============================================================================
# OU OUTPUTS
#==============================================================================
output "ou_ids" {
  description = "Map of OU names to IDs"
  value       = { for k, v in aws_organizations_organizational_unit.this : k => v.id }
}

output "ou_arns" {
  description = "Map of OU names to ARNs"
  value       = { for k, v in aws_organizations_organizational_unit.this : k => v.arn }
}

#==============================================================================
# ACCOUNT OUTPUTS
#==============================================================================
output "account_ids" {
  description = "Map of account names to IDs"
  value       = { for k, v in aws_organizations_account.this : k => v.id }
}

#==============================================================================
# POLICY OUTPUTS
#==============================================================================
output "policy_ids" {
  description = "Map of policy names to IDs"
  value       = { for k, v in aws_organizations_policy.this : k => v.id }
}
