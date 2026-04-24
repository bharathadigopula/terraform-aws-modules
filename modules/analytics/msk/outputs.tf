#==============================================================================
# CLUSTER OUTPUTS
#==============================================================================
output "cluster_arn" {
  description = "ARN of the MSK cluster"
  value       = aws_msk_cluster.this.arn
}

output "bootstrap_brokers" {
  description = "Plaintext bootstrap broker connection string"
  value       = aws_msk_cluster.this.bootstrap_brokers
}

output "bootstrap_brokers_tls" {
  description = "TLS bootstrap broker connection string"
  value       = aws_msk_cluster.this.bootstrap_brokers_tls
}

output "bootstrap_brokers_sasl_iam" {
  description = "SASL IAM bootstrap broker connection string"
  value       = aws_msk_cluster.this.bootstrap_brokers_sasl_iam
}

output "zookeeper_connect_string" {
  description = "Zookeeper connection string"
  value       = aws_msk_cluster.this.zookeeper_connect_string
}

output "current_version" {
  description = "Current cluster version"
  value       = aws_msk_cluster.this.current_version
}

#==============================================================================
# CONFIGURATION OUTPUTS
#==============================================================================
output "configuration_arn" {
  description = "ARN of the MSK configuration"
  value       = try(aws_msk_configuration.this[0].arn, null)
}
