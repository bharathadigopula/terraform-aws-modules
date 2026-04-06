#==============================================================================
# DOCUMENTDB CLUSTER OUTPUTS
#==============================================================================

output "cluster_id" {
  description = "The DocumentDB cluster identifier"
  value       = aws_docdb_cluster.this.id
}

output "cluster_arn" {
  description = "The ARN of the DocumentDB cluster"
  value       = aws_docdb_cluster.this.arn
}

output "cluster_endpoint" {
  description = "The DNS address of the DocumentDB cluster"
  value       = aws_docdb_cluster.this.endpoint
}

output "cluster_reader_endpoint" {
  description = "The read-only endpoint for the DocumentDB cluster"
  value       = aws_docdb_cluster.this.reader_endpoint
}

output "cluster_resource_id" {
  description = "The resource ID of the DocumentDB cluster"
  value       = aws_docdb_cluster.this.cluster_resource_id
}

output "cluster_port" {
  description = "The port on which the DocumentDB cluster accepts connections"
  value       = aws_docdb_cluster.this.port
}
