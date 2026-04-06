#==============================================================================
# CLUSTER OUTPUTS
#==============================================================================

output "cluster_id" {
  description = "Identifier of the Redshift cluster"
  value       = aws_redshift_cluster.this.id
}

output "cluster_arn" {
  description = "ARN of the Redshift cluster"
  value       = aws_redshift_cluster.this.arn
}

output "cluster_endpoint" {
  description = "Connection endpoint for the Redshift cluster"
  value       = aws_redshift_cluster.this.endpoint
}

output "cluster_hostname" {
  description = "DNS hostname of the Redshift cluster"
  value       = replace(aws_redshift_cluster.this.endpoint, ":${aws_redshift_cluster.this.port}", "")
}

output "cluster_port" {
  description = "Port number the Redshift cluster is listening on"
  value       = aws_redshift_cluster.this.port
}

output "cluster_database_name" {
  description = "Name of the default database in the cluster"
  value       = aws_redshift_cluster.this.database_name
}

output "cluster_vpc_security_group_ids" {
  description = "List of VPC security group IDs associated with the cluster"
  value       = aws_redshift_cluster.this.vpc_security_group_ids
}
