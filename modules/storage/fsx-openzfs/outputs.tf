#==============================================================================
# FSX OPENZFS FILE SYSTEM OUTPUTS
#==============================================================================

output "file_system_id" {
  description = "The ID of the FSx OpenZFS file system"
  value       = aws_fsx_openzfs_file_system.this.id
}

output "file_system_arn" {
  description = "The ARN of the FSx OpenZFS file system"
  value       = aws_fsx_openzfs_file_system.this.arn
}

output "dns_name" {
  description = "The DNS name of the FSx OpenZFS file system"
  value       = aws_fsx_openzfs_file_system.this.dns_name
}

output "root_volume_id" {
  description = "The ID of the root volume of the FSx OpenZFS file system"
  value       = aws_fsx_openzfs_file_system.this.root_volume_id
}

#==============================================================================
# VOLUME OUTPUTS
#==============================================================================

output "volume_ids" {
  description = "Map of volume names to their IDs"
  value       = { for k, v in aws_fsx_openzfs_volume.this : k => v.id }
}
