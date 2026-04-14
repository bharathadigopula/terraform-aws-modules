#==============================================================================
# HEALTH OUTPUTS
#==============================================================================
output "organizational_view_id" {
  description = "ID of the organizational view access resource"
  value       = try(aws_health_organizational_view_access.this[0].id, null)
}

output "event_rule_arns" {
  description = "Map of event rule names to ARNs"
  value       = { for k, v in aws_cloudwatch_event_rule.health : k => v.arn }
}
