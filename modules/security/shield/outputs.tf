#==============================================================================
# SHIELD SUBSCRIPTION OUTPUTS
#==============================================================================
output "subscription_id" {
  description = "ID of the Shield Advanced subscription"
  value       = try(aws_shield_subscription.this[0].id, null)
}

#==============================================================================
# SHIELD PROTECTION OUTPUTS
#==============================================================================
output "protection_ids" {
  description = "Map of protection names to IDs"
  value       = { for k, v in aws_shield_protection.this : k => v.id }
}

output "protection_arns" {
  description = "Map of protection names to ARNs"
  value       = { for k, v in aws_shield_protection.this : k => v.arn }
}

#==============================================================================
# PROTECTION GROUP OUTPUTS
#==============================================================================
output "protection_group_ids" {
  description = "Map of protection group IDs"
  value       = { for k, v in aws_shield_protection_group.this : k => v.id }
}
