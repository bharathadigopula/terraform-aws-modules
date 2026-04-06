#==============================================================================
# ELASTICACHE REPLICATION GROUP OUTPUTS
#==============================================================================

output "replication_group_id" {
  description = "ID of the ElastiCache replication group"
  value       = aws_elasticache_replication_group.this.id
}

output "replication_group_arn" {
  description = "ARN of the ElastiCache replication group"
  value       = aws_elasticache_replication_group.this.arn
}

output "primary_endpoint_address" {
  description = "Address of the endpoint for the primary node in the replication group"
  value       = aws_elasticache_replication_group.this.primary_endpoint_address
}

output "reader_endpoint_address" {
  description = "Address of the endpoint for the reader node in the replication group"
  value       = aws_elasticache_replication_group.this.reader_endpoint_address
}

output "configuration_endpoint_address" {
  description = "Address of the configuration endpoint for the replication group (cluster mode enabled)"
  value       = aws_elasticache_replication_group.this.configuration_endpoint_address
}

output "member_clusters" {
  description = "List of member cluster IDs in the replication group"
  value       = aws_elasticache_replication_group.this.member_clusters
}
