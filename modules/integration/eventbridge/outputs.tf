#==============================================================================
# BUS OUTPUTS
#==============================================================================
output "bus_arn" {
  description = "ARN of the event bus"
  value       = try(aws_cloudwatch_event_bus.this[0].arn, null)
}

output "bus_name" {
  description = "Name of the event bus"
  value       = try(aws_cloudwatch_event_bus.this[0].name, null)
}

#==============================================================================
# RULE OUTPUTS
#==============================================================================
output "rule_arns" {
  description = "Map of rule names to ARNs"
  value       = { for k, v in aws_cloudwatch_event_rule.this : k => v.arn }
}
