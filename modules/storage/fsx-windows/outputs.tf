#==============================================================================
# FSX WINDOWS FILE SYSTEM OUTPUTS
#==============================================================================
output "file_system_id" {
  description = "Identifier of the FSx Windows file system"
  value       = aws_fsx_windows_file_system.this.id
}

output "file_system_arn" {
  description = "ARN of the FSx Windows file system"
  value       = aws_fsx_windows_file_system.this.arn
}

output "dns_name" {
  description = "DNS name of the FSx Windows file system"
  value       = aws_fsx_windows_file_system.this.dns_name
}

output "preferred_file_server_ip" {
  description = "IP address of the primary or preferred file server"
  value       = aws_fsx_windows_file_system.this.preferred_file_server_ip
}

output "remote_administration_endpoint" {
  description = "Endpoint for the Windows Remote PowerShell management"
  value       = aws_fsx_windows_file_system.this.remote_administration_endpoint
}

output "network_interface_ids" {
  description = "List of network interface IDs associated with the file system"
  value       = aws_fsx_windows_file_system.this.network_interface_ids
}
