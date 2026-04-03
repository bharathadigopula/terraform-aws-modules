#==============================================================================
# EKS NODE GROUP OUTPUTS
#==============================================================================

output "node_group_id" {
  description = "EKS node group ID"
  value       = aws_eks_node_group.this.id
}

output "node_group_arn" {
  description = "ARN of the EKS node group"
  value       = aws_eks_node_group.this.arn
}

output "node_group_status" {
  description = "Status of the EKS node group"
  value       = aws_eks_node_group.this.status
}

output "node_group_resources" {
  description = "List of objects containing information about underlying resources of the node group (autoscaling groups, remote access security group)"
  value       = aws_eks_node_group.this.resources
}
