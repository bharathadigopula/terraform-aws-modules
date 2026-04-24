#==============================================================================
# APPLICATION OUTPUTS
#==============================================================================
output "application_id" {
  description = "ID of the Flink application"
  value       = aws_kinesisanalyticsv2_application.this.id
}

output "application_arn" {
  description = "ARN of the Flink application"
  value       = aws_kinesisanalyticsv2_application.this.arn
}

output "application_name" {
  description = "Name of the Flink application"
  value       = aws_kinesisanalyticsv2_application.this.name
}

output "version_id" {
  description = "Version ID of the Flink application"
  value       = aws_kinesisanalyticsv2_application.this.version_id
}
