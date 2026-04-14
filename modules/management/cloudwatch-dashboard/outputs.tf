#==============================================================================
# DASHBOARD OUTPUTS
#==============================================================================
output "dashboard_arns" {
  description = "Map of dashboard names to ARNs"
  value       = { for k, v in aws_cloudwatch_dashboard.this : k => v.dashboard_arn }
}
