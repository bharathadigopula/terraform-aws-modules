#==============================================================================
# FSX OPENZFS FILE SYSTEM
#==============================================================================

resource "aws_fsx_openzfs_file_system" "this" {
  storage_capacity                  = var.storage_capacity
  subnet_ids                        = var.subnet_ids
  deployment_type                   = var.deployment_type
  throughput_capacity               = var.throughput_capacity
  security_group_ids                = var.security_group_ids
  kms_key_id                        = var.kms_key_id
  storage_type                      = var.storage_type
  automatic_backup_retention_days   = var.automatic_backup_retention_days
  daily_automatic_backup_start_time = var.daily_automatic_backup_start_time
  weekly_maintenance_start_time     = var.weekly_maintenance_start_time
  copy_tags_to_backups              = var.copy_tags_to_backups
  copy_tags_to_volumes              = var.copy_tags_to_volumes

  dynamic "root_volume_configuration" {
    for_each = var.root_volume_configuration != null ? [var.root_volume_configuration] : []

    content {
      data_compression_type = root_volume_configuration.value.data_compression_type
      read_only             = root_volume_configuration.value.read_only
      record_size_kib       = root_volume_configuration.value.record_size_kib

      dynamic "nfs_exports" {
        for_each = root_volume_configuration.value.nfs_exports != null ? [root_volume_configuration.value.nfs_exports] : []

        content {
          dynamic "client_configurations" {
            for_each = nfs_exports.value.client_configurations

            content {
              clients = client_configurations.value.clients
              options = client_configurations.value.options
            }
          }
        }
      }
    }
  }

  dynamic "disk_iops_configuration" {
    for_each = var.disk_iops_configuration != null ? [var.disk_iops_configuration] : []

    content {
      mode = disk_iops_configuration.value.mode
      iops = disk_iops_configuration.value.iops
    }
  }

  tags = var.tags
}

#==============================================================================
# FSX OPENZFS VOLUMES
#==============================================================================

resource "aws_fsx_openzfs_volume" "this" {
  for_each = { for vol in var.volumes : vol.name => vol }

  name                             = each.value.name
  parent_volume_id                 = coalesce(each.value.parent_volume_id, aws_fsx_openzfs_file_system.this.root_volume_id)
  storage_capacity_quota_gib       = each.value.storage_capacity_quota_gib
  storage_capacity_reservation_gib = each.value.storage_capacity_reservation_gib
  data_compression_type            = each.value.data_compression_type

  dynamic "nfs_exports" {
    for_each = each.value.nfs_exports != null ? [each.value.nfs_exports] : []

    content {
      dynamic "client_configurations" {
        for_each = nfs_exports.value.client_configurations

        content {
          clients = client_configurations.value.clients
          options = client_configurations.value.options
        }
      }
    }
  }

  dynamic "user_and_group_quotas" {
    for_each = each.value.user_and_group_quotas != null ? each.value.user_and_group_quotas : []

    content {
      id                         = user_and_group_quotas.value.id
      storage_capacity_quota_gib = user_and_group_quotas.value.storage_capacity_quota_gib
      type                       = user_and_group_quotas.value.type
    }
  }

  tags = var.tags
}
