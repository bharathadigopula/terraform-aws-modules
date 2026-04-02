#==============================================================================
# APP RUNNER SERVICE OUTPUTS
#==============================================================================

output "service_id" {
  value       = aws_apprunner_service.this.service_id
  description = "ID of the App Runner service"
}

output "service_arn" {
  value       = aws_apprunner_service.this.arn
  description = "ARN of the App Runner service"
}

output "service_url" {
  value       = aws_apprunner_service.this.service_url
  description = "URL of the App Runner service"
}

output "service_status" {
  value       = aws_apprunner_service.this.status
  description = "Current status of the App Runner service"
}

output "auto_scaling_configuration_arn" {
  value       = var.auto_scaling_configuration != null ? aws_apprunner_auto_scaling_configuration_version.this[0].arn : null
  description = "ARN of the auto scaling configuration"
}
