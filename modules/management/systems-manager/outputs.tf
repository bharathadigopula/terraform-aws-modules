#==============================================================================
# PARAMETER OUTPUTS
#==============================================================================
output "parameter_arns" {
  description = "Map of parameter names to ARNs"
  value       = { for k, v in aws_ssm_parameter.this : k => v.arn }
}

#==============================================================================
# DOCUMENT OUTPUTS
#==============================================================================
output "document_arns" {
  description = "Map of document names to ARNs"
  value       = { for k, v in aws_ssm_document.this : k => v.arn }
}

#==============================================================================
# MAINTENANCE WINDOW OUTPUTS
#==============================================================================
output "maintenance_window_ids" {
  description = "Map of maintenance window names to IDs"
  value       = { for k, v in aws_ssm_maintenance_window.this : k => v.id }
}

#==============================================================================
# ASSOCIATION OUTPUTS
#==============================================================================
output "association_ids" {
  description = "Map of association names to IDs"
  value       = { for k, v in aws_ssm_association.this : k => v.association_id }
}
