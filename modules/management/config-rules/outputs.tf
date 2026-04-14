#==============================================================================
# RECORDER OUTPUTS
#==============================================================================
output "recorder_id" {
  description = "ID of the Config recorder"
  value       = try(aws_config_configuration_recorder.this[0].id, null)
}

#==============================================================================
# RULE OUTPUTS
#==============================================================================
output "managed_rule_arns" {
  description = "Map of managed rule names to ARNs"
  value       = { for k, v in aws_config_config_rule.managed : k => v.arn }
}

output "custom_rule_arns" {
  description = "Map of custom rule names to ARNs"
  value       = { for k, v in aws_config_config_rule.custom : k => v.arn }
}
