#==============================================================================
# CLOUDHSM OUTPUTS
#==============================================================================
output "cluster_id" {
  description = "ID of the CloudHSM cluster"
  value       = aws_cloudhsm_v2_cluster.this.cluster_id
}

output "cluster_state" {
  description = "State of the CloudHSM cluster"
  value       = aws_cloudhsm_v2_cluster.this.cluster_state
}

output "security_group_id" {
  description = "Security group ID of the CloudHSM cluster"
  value       = aws_cloudhsm_v2_cluster.this.security_group_id
}

output "hsm_ids" {
  description = "Map of HSM instance IDs"
  value       = { for k, v in aws_cloudhsm_v2_hsm.this : k => v.hsm_id }
}
