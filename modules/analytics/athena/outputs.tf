#==============================================================================
# WORKGROUP OUTPUTS
#==============================================================================
output "workgroup_id" {
  description = "ID of the Athena workgroup"
  value       = aws_athena_workgroup.this.id
}

output "workgroup_arn" {
  description = "ARN of the Athena workgroup"
  value       = aws_athena_workgroup.this.arn
}

#==============================================================================
# DATABASE OUTPUTS
#==============================================================================
output "database_ids" {
  description = "Map of database names to IDs"
  value       = { for k, v in aws_athena_database.this : k => v.id }
}

#==============================================================================
# NAMED QUERY OUTPUTS
#==============================================================================
output "named_query_ids" {
  description = "Map of named query names to IDs"
  value       = { for k, v in aws_athena_named_query.this : k => v.id }
}
