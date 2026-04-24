#==============================================================================
# CLEAN ROOMS COLLABORATION
#==============================================================================
resource "aws_cleanrooms_collaboration" "this" {
  name                     = var.name
  description              = var.description
  creator_display_name     = var.creator_display_name
  creator_member_abilities = var.creator_member_abilities
  query_log_status         = var.query_log_status

  dynamic "data_encryption_metadata" {
    for_each = var.enable_data_encryption ? [1] : []
    content {
      allow_clear_text                            = var.allow_clear_text
      allow_duplicates                            = var.allow_duplicates
      allow_joins_on_columns_with_different_names = var.allow_joins_on_columns_with_different_names
      preserve_nulls                              = var.preserve_nulls
    }
  }

  dynamic "member" {
    for_each = var.members
    content {
      account_id       = member.value.account_id
      display_name     = member.value.display_name
      member_abilities = member.value.member_abilities
    }
  }

  tags = var.tags
}

#==============================================================================
# CLEAN ROOMS CONFIGURED TABLE
#==============================================================================
resource "aws_cleanrooms_configured_table" "this" {
  for_each = { for ct in var.configured_tables : ct.name => ct }

  name            = each.value.name
  description     = each.value.description
  analysis_method = each.value.analysis_method
  allowed_columns = each.value.allowed_columns

  table_reference {
    database_name = each.value.database_name
    table_name    = each.value.table_name
  }

  tags = merge(var.tags, each.value.tags)
}
