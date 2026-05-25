#==============================================================================
# CODEARTIFACT OUTPUTS
#==============================================================================

output "domain_ids" {
  description = "Map of CodeArtifact domain IDs"
  value       = { for k, v in aws_codeartifact_domain.this : k => v.id }
}

output "domain_arns" {
  description = "Map of CodeArtifact domain ARNs"
  value       = { for k, v in aws_codeartifact_domain.this : k => v.arn }
}

output "repository_ids" {
  description = "Map of CodeArtifact repository IDs"
  value       = { for k, v in aws_codeartifact_repository.this : k => v.id }
}

output "repository_arns" {
  description = "Map of CodeArtifact repository ARNs"
  value       = { for k, v in aws_codeartifact_repository.this : k => v.arn }
}
