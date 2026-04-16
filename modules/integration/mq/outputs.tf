#==============================================================================
# BROKER OUTPUTS
#==============================================================================
output "broker_id" {
  description = "ID of the MQ broker"
  value       = aws_mq_broker.this.id
}

output "broker_arn" {
  description = "ARN of the MQ broker"
  value       = aws_mq_broker.this.arn
}

output "primary_console_url" {
  description = "Primary console URL"
  value       = try(aws_mq_broker.this.instances[0].console_url, null)
}

output "primary_endpoints" {
  description = "Primary broker endpoints"
  value       = try(aws_mq_broker.this.instances[0].endpoints, [])
}

#==============================================================================
# CONFIGURATION OUTPUTS
#==============================================================================
output "configuration_id" {
  description = "ID of the broker configuration"
  value       = try(aws_mq_configuration.this[0].id, null)
}

output "configuration_arn" {
  description = "ARN of the broker configuration"
  value       = try(aws_mq_configuration.this[0].arn, null)
}
