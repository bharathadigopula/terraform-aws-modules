#==============================================================================
# FSX LUSTRE FILE SYSTEM
#==============================================================================
resource "aws_fsx_lustre_file_system" "this" {
  storage_capacity              = var.storage_capacity
  subnet_ids                    = var.subnet_ids
  deployment_type               = var.deployment_type
  per_unit_storage_throughput   = var.per_unit_storage_throughput
  security_group_ids            = var.security_group_ids
  kms_key_id                    = var.kms_key_id
  import_path                   = var.import_path
  export_path                   = var.export_path
  imported_file_chunk_size      = var.imported_file_chunk_size
  auto_import_policy            = var.auto_import_policy
  data_compression_type         = var.data_compression_type
  storage_type                  = var.storage_type
  weekly_maintenance_start_time = var.weekly_maintenance_start_time

  automatic_backup_retention_days   = var.automatic_backup_retention_days
  daily_automatic_backup_start_time = var.daily_automatic_backup_start_time
  copy_tags_to_backups              = var.copy_tags_to_backups
  drive_cache_type                  = var.drive_cache_type
  file_system_type_version          = var.file_system_type_version

  #==============================================================================
  # LOG CONFIGURATION
  #==============================================================================
  dynamic "log_configuration" {
    for_each = var.log_configuration != null ? [var.log_configuration] : []

    content {
      level       = log_configuration.value.level
      destination = log_configuration.value.destination
    }
  }

  tags = var.tags
}
