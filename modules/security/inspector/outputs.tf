#==============================================================================
# INSPECTOR OUTPUTS
#==============================================================================
output "enabler_id" {
  description = "ID of the Inspector enabler"
  value       = aws_inspector2_enabler.this.id
}
