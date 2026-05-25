#==============================================================================
# TRANSFER FAMILY OUTPUTS
#==============================================================================

output "server_ids" {
  description = "Map of Transfer Family server IDs"
  value       = { for k, v in aws_transfer_server.this : k => v.id }
}

output "server_arns" {
  description = "Map of Transfer Family server ARNs"
  value       = { for k, v in aws_transfer_server.this : k => v.arn }
}

output "user_ids" {
  description = "Map of Transfer Family user IDs"
  value       = { for k, v in aws_transfer_user.this : k => v.id }
}

output "ssh_key_ids" {
  description = "Map of Transfer Family SSH key IDs"
  value       = { for k, v in aws_transfer_ssh_key.this : k => v.id }
}
