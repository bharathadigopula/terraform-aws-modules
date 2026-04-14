#==============================================================================
# SECURITY LAKE DATA LAKE
#==============================================================================
resource "aws_securitylake_data_lake" "this" {
  meta_store_manager_role_arn = var.meta_store_manager_role_arn

  dynamic "configuration" {
    for_each = var.configurations
    content {
      region = configuration.value.region

      encryption_configuration {
        kms_key_id = configuration.value.kms_key_id
      }

      dynamic "lifecycle_configuration" {
        for_each = configuration.value.expiration_days != null || length(configuration.value.transitions) > 0 ? [1] : []
        content {
          dynamic "expiration" {
            for_each = configuration.value.expiration_days != null ? [configuration.value.expiration_days] : []
            content {
              days = expiration.value
            }
          }

          dynamic "transition" {
            for_each = configuration.value.transitions
            content {
              days          = transition.value.days
              storage_class = transition.value.storage_class
            }
          }
        }
      }
    }
  }

  tags = var.tags
}

#==============================================================================
# AWS LOG SOURCES
#==============================================================================
resource "aws_securitylake_aws_log_source" "this" {
  for_each = { for s in var.aws_log_sources : "${s.source_name}-${s.source_version}" => s }

  source {
    accounts       = each.value.accounts
    regions        = each.value.regions
    source_name    = each.value.source_name
    source_version = each.value.source_version
  }

  depends_on = [aws_securitylake_data_lake.this]
}

#==============================================================================
# SUBSCRIBERS
#==============================================================================
resource "aws_securitylake_subscriber" "this" {
  for_each = { for s in var.subscribers : s.subscriber_name => s }

  subscriber_name        = each.value.subscriber_name
  subscriber_description = each.value.subscriber_description
  access_type            = each.value.access_type

  dynamic "source" {
    for_each = each.value.sources
    content {
      aws_log_source_resource {
        source_name    = source.value.source_name
        source_version = source.value.source_version
      }
    }
  }

  subscriber_identity {
    external_id = each.value.external_id
    principal   = each.value.principal
  }

  tags = merge(var.tags, each.value.tags)

  depends_on = [aws_securitylake_data_lake.this]
}
