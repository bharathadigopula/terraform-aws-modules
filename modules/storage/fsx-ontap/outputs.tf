#==============================================================================
# FSX ONTAP FILE SYSTEM OUTPUTS
#==============================================================================

output "file_system_id" {
  description = "The ID of the FSx ONTAP file system"
  value       = aws_fsx_ontap_file_system.this.id
}

output "file_system_arn" {
  description = "The ARN of the FSx ONTAP file system"
  value       = aws_fsx_ontap_file_system.this.arn
}

output "file_system_endpoints" {
  description = "The endpoints for the FSx ONTAP file system for management and data access"
  value       = aws_fsx_ontap_file_system.this.endpoints
}

#==============================================================================
# STORAGE VIRTUAL MACHINE OUTPUTS
#==============================================================================

output "storage_virtual_machine_id" {
  description = "The ID of the FSx ONTAP storage virtual machine"
  value       = aws_fsx_ontap_storage_virtual_machine.this.id
}

#==============================================================================
# VOLUME OUTPUTS
#==============================================================================

output "volume_ids" {
  description = "Map of volume names to their IDs"
  value       = { for k, v in aws_fsx_ontap_volume.this : k => v.id }
}
