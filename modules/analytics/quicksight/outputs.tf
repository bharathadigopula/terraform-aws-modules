#==============================================================================
# USER OUTPUTS
#==============================================================================
output "user_arns" {
  description = "Map of QuickSight user names to ARNs"
  value       = { for k, v in aws_quicksight_user.this : k => v.arn }
}

#==============================================================================
# DATA SOURCE OUTPUTS
#==============================================================================
output "data_source_arns" {
  description = "Map of data source IDs to ARNs"
  value       = { for k, v in aws_quicksight_data_source.this : k => v.arn }
}
