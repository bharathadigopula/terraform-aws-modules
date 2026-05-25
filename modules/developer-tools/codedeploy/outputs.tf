#==============================================================================
# CODEDEPLOY OUTPUTS
#==============================================================================

output "application_ids" {
  description = "Map of CodeDeploy application IDs"
  value       = { for k, v in aws_codedeploy_app.this : k => v.id }
}

output "application_arns" {
  description = "Map of CodeDeploy application ARNs"
  value       = { for k, v in aws_codedeploy_app.this : k => v.arn }
}

output "deployment_group_ids" {
  description = "Map of CodeDeploy deployment group IDs"
  value       = { for k, v in aws_codedeploy_deployment_group.this : k => v.id }
}

output "deployment_group_arns" {
  description = "Map of CodeDeploy deployment group ARNs"
  value       = { for k, v in aws_codedeploy_deployment_group.this : k => v.arn }
}
