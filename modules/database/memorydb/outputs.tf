#==============================================================================
# MEMORYDB CLUSTER OUTPUTS
#==============================================================================
output "cluster_id" {
  value       = aws_memorydb_cluster.this.id
  description = "The ID of the MemoryDB cluster"
}

output "cluster_arn" {
  value       = aws_memorydb_cluster.this.arn
  description = "The ARN of the MemoryDB cluster"
}

output "cluster_endpoint_address" {
  value       = aws_memorydb_cluster.this.cluster_endpoint[0].address
  description = "DNS hostname of the cluster configuration endpoint"
}

output "cluster_endpoint_port" {
  value       = aws_memorydb_cluster.this.cluster_endpoint[0].port
  description = "Port number of the cluster configuration endpoint"
}

output "cluster_shards" {
  value       = aws_memorydb_cluster.this.shards
  description = "Set of shards in the cluster"
}

output "engine_patch_version" {
  value       = aws_memorydb_cluster.this.engine_patch_version
  description = "Patch version number of the Redis engine used by the cluster"
}
