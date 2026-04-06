#==============================================================================
# FSX LUSTRE FILE SYSTEM OUTPUTS
#==============================================================================
output "file_system_id" {
  description = "Identifier of the FSx Lustre file system"
  value       = aws_fsx_lustre_file_system.this.id
}

output "file_system_arn" {
  description = "ARN of the FSx Lustre file system"
  value       = aws_fsx_lustre_file_system.this.arn
}

output "dns_name" {
  description = "DNS name of the FSx Lustre file system"
  value       = aws_fsx_lustre_file_system.this.dns_name
}

output "mount_name" {
  description = "Mount name used when mounting the Lustre file system"
  value       = aws_fsx_lustre_file_system.this.mount_name
}

output "network_interface_ids" {
  description = "List of network interface IDs associated with the file system"
  value       = aws_fsx_lustre_file_system.this.network_interface_ids
}
