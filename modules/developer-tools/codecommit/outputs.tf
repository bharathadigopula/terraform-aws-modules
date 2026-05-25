#==============================================================================
# CODECOMMIT OUTPUTS
#==============================================================================

output "repository_ids" {
  description = "Map of CodeCommit repository IDs"
  value       = { for k, v in aws_codecommit_repository.this : k => v.id }
}

output "repository_arns" {
  description = "Map of CodeCommit repository ARNs"
  value       = { for k, v in aws_codecommit_repository.this : k => v.arn }
}

output "clone_urls_http" {
  description = "Map of CodeCommit HTTPS clone URLs"
  value       = { for k, v in aws_codecommit_repository.this : k => v.clone_url_http }
}

output "clone_urls_ssh" {
  description = "Map of CodeCommit SSH clone URLs"
  value       = { for k, v in aws_codecommit_repository.this : k => v.clone_url_ssh }
}
