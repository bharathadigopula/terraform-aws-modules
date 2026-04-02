#==============================================================================
# IMAGE RECIPE
#==============================================================================

output "recipe_arn" {
  value       = aws_imagebuilder_image_recipe.this.arn
  description = "ARN of the image recipe"
}

#==============================================================================
# INFRASTRUCTURE CONFIGURATION
#==============================================================================

output "infrastructure_configuration_arn" {
  value       = aws_imagebuilder_infrastructure_configuration.this.arn
  description = "ARN of the infrastructure configuration"
}

#==============================================================================
# DISTRIBUTION CONFIGURATION
#==============================================================================

output "distribution_configuration_arn" {
  value       = aws_imagebuilder_distribution_configuration.this.arn
  description = "ARN of the distribution configuration"
}

#==============================================================================
# IMAGE PIPELINE
#==============================================================================

output "pipeline_arn" {
  value       = aws_imagebuilder_image_pipeline.this.arn
  description = "ARN of the image pipeline"
}
