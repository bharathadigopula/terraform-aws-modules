#==============================================================================
# LOG GROUP OUTPUTS
#==============================================================================
output "log_group_arns" {
  description = "Map of log group names to ARNs"
  value       = { for k, v in aws_cloudwatch_log_group.this : k => v.arn }
}

output "log_group_names" {
  description = "Map of log group keys to names"
  value       = { for k, v in aws_cloudwatch_log_group.this : k => v.name }
}
