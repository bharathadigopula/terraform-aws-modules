#==============================================================================
# FSX WINDOWS FILE SYSTEM
#==============================================================================
resource "aws_fsx_windows_file_system" "this" {
  storage_capacity              = var.storage_capacity
  subnet_ids                    = var.subnet_ids
  deployment_type               = var.deployment_type
  throughput_capacity           = var.throughput_capacity
  security_group_ids            = var.security_group_ids
  kms_key_id                    = var.kms_key_id
  active_directory_id           = var.active_directory_id
  storage_type                  = var.storage_type
  weekly_maintenance_start_time = var.weekly_maintenance_start_time

  automatic_backup_retention_days   = var.automatic_backup_retention_days
  daily_automatic_backup_start_time = var.daily_automatic_backup_start_time
  copy_tags_to_backups              = var.copy_tags_to_backups
  aliases                           = var.aliases

  #==============================================================================
  # SELF-MANAGED ACTIVE DIRECTORY
  #==============================================================================
  dynamic "self_managed_active_directory" {
    for_each = var.self_managed_active_directory != null ? [var.self_managed_active_directory] : []

    content {
      dns_ips                                = self_managed_active_directory.value.dns_ips
      domain_name                            = self_managed_active_directory.value.domain_name
      password                               = self_managed_active_directory.value.password
      username                               = self_managed_active_directory.value.username
      file_system_administrators_group       = self_managed_active_directory.value.file_system_administrators_group
      organizational_unit_distinguished_name = self_managed_active_directory.value.organizational_unit_distinguished_name
    }
  }

  #==============================================================================
  # AUDIT LOG CONFIGURATION
  #==============================================================================
  dynamic "audit_log_configuration" {
    for_each = var.audit_log_configuration != null ? [var.audit_log_configuration] : []

    content {
      audit_log_destination             = audit_log_configuration.value.audit_log_destination
      file_access_audit_log_level       = audit_log_configuration.value.file_access_audit_log_level
      file_share_access_audit_log_level = audit_log_configuration.value.file_share_access_audit_log_level
    }
  }

  tags = var.tags
}
