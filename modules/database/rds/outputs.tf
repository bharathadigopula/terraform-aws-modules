#==============================================================================
# RDS Instance Outputs
#==============================================================================

output "db_instance_id" {
  description = "The RDS instance ID"
  value       = aws_db_instance.this.id
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.this.arn
}

output "db_instance_endpoint" {
  description = "The connection endpoint in address:port format"
  value       = aws_db_instance.this.endpoint
}

output "db_instance_address" {
  description = "The hostname of the RDS instance"
  value       = aws_db_instance.this.address
}

output "db_instance_port" {
  description = "The database port"
  value       = aws_db_instance.this.port
}

output "db_instance_name" {
  description = "The database name"
  value       = aws_db_instance.this.db_name
}

output "db_instance_resource_id" {
  description = "The RDS resource ID of the instance"
  value       = aws_db_instance.this.resource_id
}

output "db_instance_status" {
  description = "The RDS instance status"
  value       = aws_db_instance.this.status
}
