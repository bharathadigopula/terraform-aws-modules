#==============================================================================
# CODECATALYST OUTPUTS
#==============================================================================

output "project_ids" {
  description = "Map of CodeCatalyst project IDs"
  value       = { for k, v in aws_codecatalyst_project.this : k => v.id }
}

output "project_names" {
  description = "Map of CodeCatalyst project names"
  value       = { for k, v in aws_codecatalyst_project.this : k => v.name }
}

output "source_repository_ids" {
  description = "Map of CodeCatalyst source repository IDs"
  value       = { for k, v in aws_codecatalyst_source_repository.this : k => v.id }
}

output "dev_environment_ids" {
  description = "Map of CodeCatalyst dev environment IDs"
  value       = { for k, v in aws_codecatalyst_dev_environment.this : k => v.id }
}
