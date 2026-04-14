#==============================================================================
# PERMISSION SET OUTPUTS
#==============================================================================
output "permission_set_arns" {
  description = "Map of permission set names to ARNs"
  value       = { for k, v in aws_ssoadmin_permission_set.this : k => v.arn }
}

output "permission_set_ids" {
  description = "Map of permission set names to IDs"
  value       = { for k, v in aws_ssoadmin_permission_set.this : k => v.id }
}
