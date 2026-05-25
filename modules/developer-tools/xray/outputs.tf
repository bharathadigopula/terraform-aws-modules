#==============================================================================
# XRAY OUTPUTS
#==============================================================================

output "encryption_config_id" {
  description = "The ID of the X-Ray encryption configuration"
  value       = try(aws_xray_encryption_config.this[0].id, null)
}

output "group_arns" {
  description = "Map of X-Ray group ARNs"
  value       = { for k, v in aws_xray_group.this : k => v.arn }
}

output "sampling_rule_ids" {
  description = "Map of X-Ray sampling rule IDs"
  value       = { for k, v in aws_xray_sampling_rule.this : k => v.id }
}
