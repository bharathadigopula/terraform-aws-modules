#==============================================================================
# DATASYNC OUTPUTS
#==============================================================================

output "s3_location_arns" {
  description = "Map of DataSync S3 location ARNs"
  value       = { for k, v in aws_datasync_location_s3.this : k => v.arn }
}

output "task_ids" {
  description = "Map of DataSync task IDs"
  value       = { for k, v in aws_datasync_task.this : k => v.id }
}

output "task_arns" {
  description = "Map of DataSync task ARNs"
  value       = { for k, v in aws_datasync_task.this : k => v.arn }
}
