#==============================================================================
# NEPTUNE CLUSTER OUTPUTS
#==============================================================================
output "cluster_id" {
  value       = aws_neptune_cluster.this.id
  description = "The ID of the Neptune cluster"
}

output "cluster_arn" {
  value       = aws_neptune_cluster.this.arn
  description = "The ARN of the Neptune cluster"
}

output "cluster_endpoint" {
  value       = aws_neptune_cluster.this.endpoint
  description = "The DNS address of the Neptune cluster"
}

output "cluster_reader_endpoint" {
  value       = aws_neptune_cluster.this.reader_endpoint
  description = "A read-only endpoint for the Neptune cluster"
}

output "cluster_resource_id" {
  value       = aws_neptune_cluster.this.cluster_resource_id
  description = "The resource ID of the Neptune cluster"
}

output "cluster_port" {
  value       = aws_neptune_cluster.this.port
  description = "The port on which the Neptune cluster accepts connections"
}
