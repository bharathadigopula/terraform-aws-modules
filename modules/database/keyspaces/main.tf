#==============================================================================
# LOCALS
#==============================================================================

locals {
  tables_map = { for table in var.tables : table.table_name => table }
}

#==============================================================================
# AMAZON KEYSPACES KEYSPACE
#==============================================================================

resource "aws_keyspaces_keyspace" "this" {
  name = var.keyspace_name

  tags = var.tags
}

#==============================================================================
# AMAZON KEYSPACES TABLES
#==============================================================================

resource "aws_keyspaces_table" "this" {
  for_each = local.tables_map

  keyspace_name = aws_keyspaces_keyspace.this.name
  table_name    = each.key

  #==============================================================================
  # SCHEMA DEFINITION
  #==============================================================================

  schema_definition {
    dynamic "column" {
      for_each = each.value.schema_definition.all_columns
      content {
        name = column.value.name
        type = column.value.type
      }
    }

    dynamic "partition_key" {
      for_each = each.value.schema_definition.partition_key
      content {
        name = partition_key.value
      }
    }

    dynamic "clustering_key" {
      for_each = each.value.schema_definition.clustering_key
      content {
        name     = clustering_key.value.name
        order_by = clustering_key.value.order_by
      }
    }

    dynamic "static_column" {
      for_each = each.value.schema_definition.static_columns
      content {
        name = static_column.value
      }
    }
  }

  #==============================================================================
  # POINT IN TIME RECOVERY
  #==============================================================================

  point_in_time_recovery {
    status = each.value.point_in_time_recovery ? "ENABLED" : "DISABLED"
  }

  #==============================================================================
  # CAPACITY SPECIFICATION
  #==============================================================================

  capacity_specification {
    throughput_mode      = each.value.throughput_mode
    read_capacity_units  = each.value.throughput_mode == "PROVISIONED" ? each.value.read_capacity_units : null
    write_capacity_units = each.value.throughput_mode == "PROVISIONED" ? each.value.write_capacity_units : null
  }

  #==============================================================================
  # DEFAULT TIME TO LIVE
  #==============================================================================

  default_time_to_live = each.value.default_time_to_live

  #==============================================================================
  # ENCRYPTION SPECIFICATION
  #==============================================================================

  encryption_specification {
    type               = each.value.encryption_type
    kms_key_identifier = each.value.encryption_type == "CUSTOMER_MANAGED_KMS_KEY" ? each.value.kms_key_identifier : null
  }

  tags = var.tags
}
