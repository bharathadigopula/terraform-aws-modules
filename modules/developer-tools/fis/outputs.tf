#==============================================================================
# FIS OUTPUTS
#==============================================================================

output "experiment_template_ids" {
  description = "Map of FIS experiment template IDs"
  value       = { for k, v in aws_fis_experiment_template.this : k => v.id }
}

output "experiment_template_arns" {
  description = "Map of FIS experiment template ARNs"
  value       = { for k, v in aws_fis_experiment_template.this : k => v.arn }
}
