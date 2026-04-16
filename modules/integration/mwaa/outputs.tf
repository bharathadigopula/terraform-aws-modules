#==============================================================================
# ENVIRONMENT OUTPUTS
#==============================================================================
output "environment_arn" {
  description = "ARN of the MWAA environment"
  value       = aws_mwaa_environment.this.arn
}

output "webserver_url" {
  description = "Webserver URL of the MWAA environment"
  value       = aws_mwaa_environment.this.webserver_url
}

output "status" {
  description = "Status of the MWAA environment"
  value       = aws_mwaa_environment.this.status
}

output "service_role_arn" {
  description = "Service role ARN created by MWAA"
  value       = aws_mwaa_environment.this.service_role_arn
}
