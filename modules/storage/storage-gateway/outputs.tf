#==============================================================================
# GATEWAY OUTPUTS
#==============================================================================
output "gateway_id" {
  description = "ID of the Storage Gateway"
  value       = aws_storagegateway_gateway.this.id
}

output "gateway_arn" {
  description = "ARN of the Storage Gateway"
  value       = aws_storagegateway_gateway.this.arn
}

output "gateway_type" {
  description = "Type of the Storage Gateway"
  value       = aws_storagegateway_gateway.this.gateway_type
}

#==============================================================================
# FILE SHARE OUTPUTS
#==============================================================================
output "nfs_file_share_arns" {
  description = "Map of NFS file share names to their ARNs"
  value       = { for k, v in aws_storagegateway_nfs_file_share.this : k => v.arn }
}

output "smb_file_share_arns" {
  description = "Map of SMB file share names to their ARNs"
  value       = { for k, v in aws_storagegateway_smb_file_share.this : k => v.arn }
}
