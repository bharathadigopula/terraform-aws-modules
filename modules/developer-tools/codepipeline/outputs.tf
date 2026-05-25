#==============================================================================
# CODEPIPELINE OUTPUTS
#==============================================================================

output "pipeline_ids" {
  description = "Map of CodePipeline IDs"
  value       = { for k, v in aws_codepipeline.this : k => v.id }
}

output "pipeline_arns" {
  description = "Map of CodePipeline ARNs"
  value       = { for k, v in aws_codepipeline.this : k => v.arn }
}

output "pipeline_names" {
  description = "Map of CodePipeline names"
  value       = { for k, v in aws_codepipeline.this : k => v.name }
}
