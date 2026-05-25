#==============================================================================
# SNOW FAMILY OUTPUTS
#==============================================================================

output "resource_ids" {
  description = "Map of Snow Family Cloud Control resource IDs"
  value       = { for k, v in aws_cloudcontrolapi_resource.this : k => v.id }
}

output "resource_properties" {
  description = "Map of Snow Family Cloud Control resource properties"
  value       = { for k, v in aws_cloudcontrolapi_resource.this : k => v.properties }
}
