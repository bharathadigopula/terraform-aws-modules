#==============================================================================
# DATA SET OUTPUTS
#==============================================================================
output "data_set_id" {
  description = "ID of the Data Exchange data set"
  value       = aws_dataexchange_data_set.this.id
}

output "data_set_arn" {
  description = "ARN of the Data Exchange data set"
  value       = aws_dataexchange_data_set.this.arn
}

#==============================================================================
# REVISION OUTPUTS
#==============================================================================
output "revision_ids" {
  description = "Map of revision comments to IDs"
  value       = { for k, v in aws_dataexchange_revision.this : k => v.revision_id }
}
