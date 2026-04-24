#==============================================================================
# COLLABORATION OUTPUTS
#==============================================================================
output "collaboration_id" {
  description = "ID of the Clean Rooms collaboration"
  value       = aws_cleanrooms_collaboration.this.id
}

output "collaboration_arn" {
  description = "ARN of the Clean Rooms collaboration"
  value       = aws_cleanrooms_collaboration.this.arn
}

#==============================================================================
# CONFIGURED TABLE OUTPUTS
#==============================================================================
output "configured_table_ids" {
  description = "Map of configured table names to IDs"
  value       = { for k, v in aws_cleanrooms_configured_table.this : k => v.id }
}
