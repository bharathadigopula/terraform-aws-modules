#==============================================================================
# TIMESTREAM DATABASE OUTPUTS
#==============================================================================

output "database_name" {
  description = "The name of the Timestream database"
  value       = aws_timestreamwrite_database.this.database_name
}

output "database_arn" {
  description = "The ARN of the Timestream database"
  value       = aws_timestreamwrite_database.this.arn
}

output "table_arns" {
  description = "Map of Timestream table names to their ARNs"
  value       = { for k, v in aws_timestreamwrite_table.this : k => v.arn }
}
