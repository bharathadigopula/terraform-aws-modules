#==============================================================================
# VERIFIED PERMISSIONS POLICY STORE
#==============================================================================
resource "aws_verifiedpermissions_policy_store" "this" {
  validation_settings {
    mode = var.validation_mode
  }

  description = var.description
}

#==============================================================================
# SCHEMA
#==============================================================================
resource "aws_verifiedpermissions_schema" "this" {
  count = var.schema != null ? 1 : 0

  policy_store_id = aws_verifiedpermissions_policy_store.this.id

  definition {
    value = var.schema
  }
}

#==============================================================================
# STATIC POLICIES
#==============================================================================
resource "aws_verifiedpermissions_policy" "static" {
  for_each = { for p in var.static_policies : p.description => p }

  policy_store_id = aws_verifiedpermissions_policy_store.this.id

  definition {
    static {
      description = each.value.description
      statement   = each.value.statement
    }
  }
}

#==============================================================================
# IDENTITY SOURCES
#==============================================================================
resource "aws_verifiedpermissions_identity_source" "this" {
  for_each = { for s in var.identity_sources : s.user_pool_arn => s }

  policy_store_id = aws_verifiedpermissions_policy_store.this.id

  configuration {
    cognito_user_pool_configuration {
      user_pool_arn = each.value.user_pool_arn

      dynamic "group_configuration" {
        for_each = each.value.group_entity_type != null ? [1] : []
        content {
          group_entity_type = each.value.group_entity_type
        }
      }
    }
  }

  principal_entity_type = each.value.principal_entity_type
}
