#==============================================================================
# Aurora Cluster Outputs
#==============================================================================

output "cluster_id" {
  description = "The Aurora cluster ID"
  value       = aws_rds_cluster.this.id
}

output "cluster_arn" {
  description = "The ARN of the Aurora cluster"
  value       = aws_rds_cluster.this.arn
}

output "cluster_endpoint" {
  description = "The cluster writer endpoint"
  value       = aws_rds_cluster.this.endpoint
}

output "cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = aws_rds_cluster.this.reader_endpoint
}

output "cluster_port" {
  description = "The database port"
  value       = aws_rds_cluster.this.port
}

output "cluster_members" {
  description = "List of cluster instance identifiers"
  value       = aws_rds_cluster.this.cluster_members
}

output "cluster_resource_id" {
  description = "The cluster resource ID"
  value       = aws_rds_cluster.this.cluster_resource_id
}

output "instance_endpoints" {
  description = "List of endpoints for the cluster instances"
  value       = aws_rds_cluster_instance.this[*].endpoint
}
