#==============================================================================
# ACCELERATOR OUTPUTS
#==============================================================================

output "accelerator_id" {
  value       = aws_globalaccelerator_accelerator.this.id
  description = "ID of the Global Accelerator"
}

output "accelerator_dns_name" {
  value       = aws_globalaccelerator_accelerator.this.dns_name
  description = "DNS name of the Global Accelerator"
}

output "accelerator_hosted_zone_id" {
  value       = aws_globalaccelerator_accelerator.this.hosted_zone_id
  description = "Route53 hosted zone ID for the Global Accelerator"
}

output "accelerator_ip_sets" {
  value       = aws_globalaccelerator_accelerator.this.ip_sets
  description = "IP sets associated with the Global Accelerator"
}

#==============================================================================
# LISTENER OUTPUTS
#==============================================================================

output "listener_ids" {
  value       = aws_globalaccelerator_listener.this[*].id
  description = "IDs of the listeners"
}

#==============================================================================
# ENDPOINT GROUP OUTPUTS
#==============================================================================

output "endpoint_group_ids" {
  value       = aws_globalaccelerator_endpoint_group.this[*].id
  description = "IDs of the endpoint groups"
}
