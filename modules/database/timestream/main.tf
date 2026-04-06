#==============================================================================
# TIMESTREAM DATABASE
#==============================================================================

resource "aws_timestreamwrite_database" "this" {
  database_name = var.database_name
  kms_key_id    = var.kms_key_id
  tags          = var.tags
}

#==============================================================================
# TIMESTREAM TABLES
#==============================================================================

resource "aws_timestreamwrite_table" "this" {
  for_each = { for table in var.tables : table.table_name => table }

  database_name = aws_timestreamwrite_database.this.database_name
  table_name    = each.value.table_name
  tags          = var.tags

  dynamic "retention_properties" {
    for_each = each.value.retention_properties != null ? [each.value.retention_properties] : []

    content {
      memory_store_retention_period_in_hours  = retention_properties.value.memory_store_retention_period_in_hours
      magnetic_store_retention_period_in_days = retention_properties.value.magnetic_store_retention_period_in_days
    }
  }

  dynamic "magnetic_store_write_properties" {
    for_each = each.value.magnetic_store_write_properties != null ? [each.value.magnetic_store_write_properties] : []

    content {
      enable_magnetic_store_writes = magnetic_store_write_properties.value.enable_magnetic_store_writes
    }
  }
}
