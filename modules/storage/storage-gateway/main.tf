#==============================================================================
# STORAGE GATEWAY
#==============================================================================
resource "aws_storagegateway_gateway" "this" {
  gateway_name       = var.gateway_name
  gateway_type       = var.gateway_type
  gateway_timezone   = var.gateway_timezone
  gateway_ip_address = var.gateway_ip_address
  activation_key     = var.activation_key

  cloudwatch_log_group_arn = var.cloudwatch_log_group_arn

  dynamic "smb_active_directory_settings" {
    for_each = var.smb_active_directory_settings != null ? [var.smb_active_directory_settings] : []
    content {
      domain_name = smb_active_directory_settings.value.domain_name
      username    = smb_active_directory_settings.value.username
      password    = smb_active_directory_settings.value.password
    }
  }

  smb_guest_password = var.smb_guest_password

  tags = var.tags
}

#==============================================================================
# NFS FILE SHARES
#==============================================================================
resource "aws_storagegateway_nfs_file_share" "this" {
  for_each = { for share in var.nfs_file_shares : share.file_share_name => share }

  client_list           = each.value.client_list
  file_share_name       = each.value.file_share_name
  gateway_arn           = aws_storagegateway_gateway.this.arn
  location_arn          = each.value.location_arn
  role_arn              = each.value.role_arn
  kms_encrypted         = each.value.kms_encrypted
  kms_key_arn           = each.value.kms_key_arn
  default_storage_class = each.value.default_storage_class
  squash                = each.value.squash

  tags = var.tags
}

#==============================================================================
# SMB FILE SHARES
#==============================================================================
resource "aws_storagegateway_smb_file_share" "this" {
  for_each = { for share in var.smb_file_shares : share.file_share_name => share }

  file_share_name       = each.value.file_share_name
  gateway_arn           = aws_storagegateway_gateway.this.arn
  location_arn          = each.value.location_arn
  role_arn              = each.value.role_arn
  kms_encrypted         = each.value.kms_encrypted
  kms_key_arn           = each.value.kms_key_arn
  default_storage_class = each.value.default_storage_class
  authentication        = each.value.authentication

  tags = var.tags
}
