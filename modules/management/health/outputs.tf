#==============================================================================
# HEALTH OUTPUTS
#==============================================================================
output "event_rule_arns" {
  description = "Map of event rule names to ARNs"
  value       = { for k, v in aws_cloudwatch_event_rule.health : k => v.arn }
}
