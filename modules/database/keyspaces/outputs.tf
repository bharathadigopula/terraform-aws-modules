#==============================================================================
# KEYSPACE OUTPUTS
#==============================================================================

output "keyspace_name" {
  description = "Name of the created keyspace"
  value       = aws_keyspaces_keyspace.this.name
}

output "keyspace_arn" {
  description = "ARN of the created keyspace"
  value       = aws_keyspaces_keyspace.this.arn
}

#==============================================================================
# TABLE OUTPUTS
#==============================================================================

output "table_arns" {
  description = "Map of table names to their ARNs"
  value       = { for k, v in aws_keyspaces_table.this : k => v.arn }
}
