#==============================================================================
# INSTANCE IDENTIFIERS
#==============================================================================

output "instance_ids" {
  value       = aws_instance.this[*].id
  description = "List of EC2 instance IDs"
}

output "instance_arns" {
  value       = aws_instance.this[*].arn
  description = "List of EC2 instance ARNs"
}

#==============================================================================
# NETWORK INFORMATION
#==============================================================================

output "private_ips" {
  value       = aws_instance.this[*].private_ip
  description = "List of private IP addresses"
}

output "public_ips" {
  value       = aws_instance.this[*].public_ip
  description = "List of public IP addresses"
}

output "primary_network_interface_ids" {
  value       = aws_instance.this[*].primary_network_interface_id
  description = "List of primary ENI IDs"
}

#==============================================================================
# INSTANCE STATE
#==============================================================================

output "instance_states" {
  value       = aws_instance.this[*].instance_state
  description = "List of instance states"
}
