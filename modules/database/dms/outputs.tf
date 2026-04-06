#==============================================================================
# DMS Replication Instance Outputs
#==============================================================================
output "replication_instance_arn" {
  description = "The ARN of the DMS replication instance"
  value       = aws_dms_replication_instance.this.replication_instance_arn
}

output "replication_instance_id" {
  description = "The identifier of the DMS replication instance"
  value       = aws_dms_replication_instance.this.replication_instance_id
}

output "replication_subnet_group_id" {
  description = "The identifier of the DMS replication subnet group"
  value       = local.replication_subnet_group_id
}

#==============================================================================
# DMS Endpoint Outputs
#==============================================================================
output "source_endpoint_arns" {
  description = "Map of source endpoint IDs to their ARNs"
  value       = { for k, v in aws_dms_endpoint.source : k => v.endpoint_arn }
}

output "target_endpoint_arns" {
  description = "Map of target endpoint IDs to their ARNs"
  value       = { for k, v in aws_dms_endpoint.target : k => v.endpoint_arn }
}

#==============================================================================
# DMS Replication Task Outputs
#==============================================================================
output "replication_task_arns" {
  description = "Map of replication task IDs to their ARNs"
  value       = { for k, v in aws_dms_replication_task.this : k => v.replication_task_arn }
}
