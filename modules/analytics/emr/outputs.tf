#==============================================================================
# CLUSTER OUTPUTS
#==============================================================================
output "cluster_id" {
  description = "ID of the EMR cluster"
  value       = aws_emr_cluster.this.id
}

output "cluster_arn" {
  description = "ARN of the EMR cluster"
  value       = aws_emr_cluster.this.arn
}

output "master_public_dns" {
  description = "Public DNS of the master node"
  value       = aws_emr_cluster.this.master_public_dns
}

output "cluster_state" {
  description = "State of the cluster"
  value       = aws_emr_cluster.this.cluster_state
}

output "security_configuration_name" {
  description = "Name of the security configuration"
  value       = try(aws_emr_security_configuration.this[0].name, null)
}
