#==============================================================================
# FSX ONTAP FILE SYSTEM
#==============================================================================

resource "aws_fsx_ontap_file_system" "this" {
  storage_capacity                  = var.storage_capacity
  subnet_ids                        = var.subnet_ids
  deployment_type                   = var.deployment_type
  throughput_capacity               = var.throughput_capacity
  preferred_subnet_id               = var.preferred_subnet_id
  security_group_ids                = var.security_group_ids
  kms_key_id                        = var.kms_key_id
  fsx_admin_password                = var.fsx_admin_password
  endpoint_ip_address_range         = var.endpoint_ip_address_range
  route_table_ids                   = var.route_table_ids
  automatic_backup_retention_days   = var.automatic_backup_retention_days
  daily_automatic_backup_start_time = var.daily_automatic_backup_start_time
  weekly_maintenance_start_time     = var.weekly_maintenance_start_time

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
# FSX ONTAP STORAGE VIRTUAL MACHINE
#==============================================================================

resource "aws_fsx_ontap_storage_virtual_machine" "this" {
  file_system_id = aws_fsx_ontap_file_system.this.id
  name           = "svm-default"

  tags = var.tags
}

#==============================================================================
# FSX ONTAP VOLUMES
#==============================================================================

resource "aws_fsx_ontap_volume" "this" {
  for_each = { for vol in var.storage_volumes : vol.name => vol }

  name                       = each.value.name
  junction_path              = each.value.junction_path
  size_in_megabytes          = each.value.size_in_megabytes
  storage_efficiency_enabled = each.value.storage_efficiency_enabled
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.this.id
  security_style             = each.value.security_style

  dynamic "tiering_policy" {
    for_each = each.value.tiering_policy_name != null ? [1] : []

    content {
      name           = each.value.tiering_policy_name
      cooling_period = each.value.tiering_policy_cooling_period
    }
  }

  tags = var.tags
}
