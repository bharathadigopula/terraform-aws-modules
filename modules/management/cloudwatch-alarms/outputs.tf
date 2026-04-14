#==============================================================================
# ALARM OUTPUTS
#==============================================================================
output "alarm_arns" {
  description = "Map of alarm names to ARNs"
  value       = { for k, v in aws_cloudwatch_metric_alarm.this : k => v.arn }
}

output "alarm_ids" {
  description = "Map of alarm names to IDs"
  value       = { for k, v in aws_cloudwatch_metric_alarm.this : k => v.id }
}
