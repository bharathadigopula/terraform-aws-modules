#==============================================================================
# EFS FILE SYSTEM OUTPUTS
#==============================================================================
output "file_system_id" {
  description = "ID of the EFS file system"
  value       = aws_efs_file_system.this.id
}

output "file_system_arn" {
  description = "ARN of the EFS file system"
  value       = aws_efs_file_system.this.arn
}

output "file_system_dns_name" {
  description = "DNS name of the EFS file system"
  value       = aws_efs_file_system.this.dns_name
}

#==============================================================================
# MOUNT TARGET OUTPUTS
#==============================================================================
output "mount_target_ids" {
  description = "List of mount target IDs"
  value       = aws_efs_mount_target.this[*].id
}

output "mount_target_dns_names" {
  description = "List of mount target DNS names"
  value       = aws_efs_mount_target.this[*].dns_name
}

#==============================================================================
# ACCESS POINT OUTPUTS
#==============================================================================
output "access_point_ids" {
  description = "Map of access point names to their IDs"
  value       = { for k, v in aws_efs_access_point.this : k => v.id }
}
