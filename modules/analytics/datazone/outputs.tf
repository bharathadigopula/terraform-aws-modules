#==============================================================================
# DOMAIN OUTPUTS
#==============================================================================
output "domain_id" {
  description = "ID of the DataZone domain"
  value       = aws_datazone_domain.this.id
}

output "domain_arn" {
  description = "ARN of the DataZone domain"
  value       = aws_datazone_domain.this.arn
}

output "portal_url" {
  description = "Portal URL of the domain"
  value       = aws_datazone_domain.this.portal_url
}

#==============================================================================
# PROJECT OUTPUTS
#==============================================================================
output "project_ids" {
  description = "Map of project names to IDs"
  value       = { for k, v in aws_datazone_project.this : k => v.id }
}
