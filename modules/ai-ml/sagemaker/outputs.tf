#==============================================================================
# SAGEMAKER OUTPUTS
#==============================================================================

output "notebook_instance_arns" {
  description = "Map of SageMaker notebook instance ARNs"
  value       = { for k, v in aws_sagemaker_notebook_instance.this : k => v.arn }
}

output "notebook_instance_urls" {
  description = "Map of SageMaker notebook instance URLs"
  value       = { for k, v in aws_sagemaker_notebook_instance.this : k => v.url }
}

output "model_names" {
  description = "Map of SageMaker model names"
  value       = { for k, v in aws_sagemaker_model.this : k => v.name }
}

output "endpoint_configuration_names" {
  description = "Map of SageMaker endpoint configuration names"
  value       = { for k, v in aws_sagemaker_endpoint_configuration.this : k => v.name }
}

output "endpoint_names" {
  description = "Map of SageMaker endpoint names"
  value       = { for k, v in aws_sagemaker_endpoint.this : k => v.name }
}
