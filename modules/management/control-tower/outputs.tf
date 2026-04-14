#==============================================================================
# LANDING ZONE OUTPUTS
#==============================================================================
output "landing_zone_id" {
  description = "ID of the Control Tower landing zone"
  value       = try(aws_controltower_landing_zone.this[0].id, null)
}

output "landing_zone_arn" {
  description = "ARN of the Control Tower landing zone"
  value       = try(aws_controltower_landing_zone.this[0].arn, null)
}

#==============================================================================
# CONTROL OUTPUTS
#==============================================================================
output "control_arns" {
  description = "Map of control keys to ARNs"
  value       = { for k, v in aws_controltower_control.this : k => v.arn }
}
