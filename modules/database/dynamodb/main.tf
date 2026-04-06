#==============================================================================
# DYNAMODB TABLE
#==============================================================================

resource "aws_dynamodb_table" "this" {
  name         = var.name
  billing_mode = var.billing_mode
  hash_key     = var.hash_key
  range_key    = var.range_key
  table_class  = var.table_class

  read_capacity  = var.billing_mode == "PROVISIONED" ? var.read_capacity : null
  write_capacity = var.billing_mode == "PROVISIONED" ? var.write_capacity : null

  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_enabled ? var.stream_view_type : null

  #==============================================================================
  # ATTRIBUTE DEFINITIONS
  #==============================================================================

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  #==============================================================================
  # GLOBAL SECONDARY INDEXES
  #==============================================================================

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indexes
    content {
      name               = global_secondary_index.value.name
      hash_key           = global_secondary_index.value.hash_key
      range_key          = global_secondary_index.value.range_key
      projection_type    = global_secondary_index.value.projection_type
      non_key_attributes = global_secondary_index.value.non_key_attributes
      read_capacity      = var.billing_mode == "PROVISIONED" ? global_secondary_index.value.read_capacity : null
      write_capacity     = var.billing_mode == "PROVISIONED" ? global_secondary_index.value.write_capacity : null
    }
  }

  #==============================================================================
  # LOCAL SECONDARY INDEXES
  #==============================================================================

  dynamic "local_secondary_index" {
    for_each = var.local_secondary_indexes
    content {
      name               = local_secondary_index.value.name
      range_key          = local_secondary_index.value.range_key
      projection_type    = local_secondary_index.value.projection_type
      non_key_attributes = local_secondary_index.value.non_key_attributes
    }
  }

  #==============================================================================
  # TTL
  #==============================================================================

  dynamic "ttl" {
    for_each = var.ttl != null ? [var.ttl] : []
    content {
      attribute_name = ttl.value.attribute_name
      enabled        = ttl.value.enabled
    }
  }

  #==============================================================================
  # POINT IN TIME RECOVERY
  #==============================================================================

  point_in_time_recovery {
    enabled = var.point_in_time_recovery_enabled
  }

  #==============================================================================
  # SERVER SIDE ENCRYPTION
  #==============================================================================

  server_side_encryption {
    enabled     = var.server_side_encryption.enabled
    kms_key_arn = var.server_side_encryption.kms_key_arn
  }

  #==============================================================================
  # GLOBAL TABLE REPLICAS
  #==============================================================================

  dynamic "replica" {
    for_each = var.replica_regions
    content {
      region_name = replica.value
    }
  }

  tags = var.tags
}
