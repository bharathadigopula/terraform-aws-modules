#==============================================================================
# CODEBUILD OUTPUTS
#==============================================================================

output "project_ids" {
  description = "Map of CodeBuild project IDs"
  value       = { for k, v in aws_codebuild_project.this : k => v.id }
}

output "project_arns" {
  description = "Map of CodeBuild project ARNs"
  value       = { for k, v in aws_codebuild_project.this : k => v.arn }
}

output "badge_urls" {
  description = "Map of CodeBuild badge URLs"
  value       = { for k, v in aws_codebuild_project.this : k => v.badge_url }
}
