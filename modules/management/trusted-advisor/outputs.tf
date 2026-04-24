#==============================================================================
# TRUSTED ADVISOR OUTPUTS
#==============================================================================
output "organizational_view_id" {
  description = "ID of the organizational view resource"
  value       = try(aws_trustedadvisor_organizational_view.this[0].id, null)
}
