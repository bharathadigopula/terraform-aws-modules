#==============================================================================
# SWF DOMAIN OUTPUTS
#==============================================================================
output "domain_id" {
  description = "ID of the SWF domain"
  value       = aws_swf_domain.this.id
}

output "domain_arn" {
  description = "ARN of the SWF domain"
  value       = aws_swf_domain.this.arn
}

output "domain_name" {
  description = "Name of the SWF domain"
  value       = aws_swf_domain.this.name
}
