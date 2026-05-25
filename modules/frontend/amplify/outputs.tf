#==============================================================================
# AMPLIFY OUTPUTS
#==============================================================================

output "app_ids" {
  description = "Map of Amplify app IDs"
  value       = { for k, v in aws_amplify_app.this : k => v.id }
}

output "app_arns" {
  description = "Map of Amplify app ARNs"
  value       = { for k, v in aws_amplify_app.this : k => v.arn }
}

output "branch_ids" {
  description = "Map of Amplify branch IDs"
  value       = { for k, v in aws_amplify_branch.this : k => v.id }
}

output "domain_association_ids" {
  description = "Map of Amplify domain association IDs"
  value       = { for k, v in aws_amplify_domain_association.this : k => v.id }
}
