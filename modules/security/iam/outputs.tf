#==============================================================================
# IAM ROLE OUTPUTS
#==============================================================================
output "role_arns" {
  description = "Map of role names to ARNs"
  value       = { for k, v in aws_iam_role.this : k => v.arn }
}

output "role_names" {
  description = "Map of role keys to names"
  value       = { for k, v in aws_iam_role.this : k => v.name }
}

output "instance_profile_arns" {
  description = "Map of instance profile names to ARNs"
  value       = { for k, v in aws_iam_instance_profile.this : k => v.arn }
}

#==============================================================================
# IAM POLICY OUTPUTS
#==============================================================================
output "policy_arns" {
  description = "Map of policy names to ARNs"
  value       = { for k, v in aws_iam_policy.this : k => v.arn }
}

#==============================================================================
# IAM USER OUTPUTS
#==============================================================================
output "user_arns" {
  description = "Map of user names to ARNs"
  value       = { for k, v in aws_iam_user.this : k => v.arn }
}

#==============================================================================
# IAM GROUP OUTPUTS
#==============================================================================
output "group_arns" {
  description = "Map of group names to ARNs"
  value       = { for k, v in aws_iam_group.this : k => v.arn }
}
