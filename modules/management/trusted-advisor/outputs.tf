#==============================================================================
# TRUSTED ADVISOR OUTPUTS
#==============================================================================
output "organization_access_id" {
  description = "ID of the organization access resource"
  value       = try(aws_trustedadvisor_organization_access.this[0].id, null)
}
