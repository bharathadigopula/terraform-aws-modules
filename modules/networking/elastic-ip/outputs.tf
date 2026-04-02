#==============================================================================
# ELASTIC IP OUTPUTS
#==============================================================================

output "eip_ids" {
  description = "List of Elastic IP IDs"
  value       = aws_eip.this[*].id
}

output "eip_public_ips" {
  description = "List of public IP addresses"
  value       = aws_eip.this[*].public_ip
}

output "eip_allocation_ids" {
  description = "List of Elastic IP allocation IDs"
  value       = aws_eip.this[*].allocation_id
}

output "eip_private_ips" {
  description = "List of private IP addresses associated with the EIPs (VPC only)"
  value       = aws_eip.this[*].private_ip
}

output "instance_association_ids" {
  description = "List of EIP association IDs for instance associations"
  value       = aws_eip_association.instance[*].id
}

output "eni_association_ids" {
  description = "List of EIP association IDs for ENI associations"
  value       = aws_eip_association.eni[*].id
}
