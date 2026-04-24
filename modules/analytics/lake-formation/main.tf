#==============================================================================
# LAKE FORMATION DATA LAKE SETTINGS
#==============================================================================
resource "aws_lakeformation_data_lake_settings" "this" {
  admins                                = var.admins
  read_only_admins                      = var.read_only_admins
  trusted_resource_owners               = var.trusted_resource_owners
  allow_external_data_filtering         = var.allow_external_data_filtering
  allow_full_table_external_data_access = var.allow_full_table_external_data_access
  external_data_filtering_allow_list    = var.external_data_filtering_allow_list

  dynamic "create_database_default_permissions" {
    for_each = var.create_database_default_permissions
    content {
      permissions = create_database_default_permissions.value.permissions
      principal   = create_database_default_permissions.value.principal
    }
  }

  dynamic "create_table_default_permissions" {
    for_each = var.create_table_default_permissions
    content {
      permissions = create_table_default_permissions.value.permissions
      principal   = create_table_default_permissions.value.principal
    }
  }
}

#==============================================================================
# LAKE FORMATION RESOURCE
#==============================================================================
resource "aws_lakeformation_resource" "this" {
  for_each = { for r in var.resources : r.arn => r }

  arn                     = each.value.arn
  role_arn                = each.value.role_arn
  use_service_linked_role = each.value.use_service_linked_role
  hybrid_access_enabled   = each.value.hybrid_access_enabled
}

#==============================================================================
# LAKE FORMATION PERMISSIONS
#==============================================================================
resource "aws_lakeformation_permissions" "this" {
  for_each = { for idx, p in var.permissions : idx => p }

  principal                     = each.value.principal
  permissions                   = each.value.permissions
  permissions_with_grant_option = each.value.permissions_with_grant_option
  catalog_id                    = each.value.catalog_id
  catalog_resource              = each.value.catalog_resource

  dynamic "database" {
    for_each = each.value.database_name != null ? [1] : []
    content {
      name       = each.value.database_name
      catalog_id = each.value.catalog_id
    }
  }

  dynamic "table" {
    for_each = each.value.table_name != null ? [1] : []
    content {
      database_name = each.value.database_name
      name          = each.value.table_name
      catalog_id    = each.value.catalog_id
    }
  }

  dynamic "data_location" {
    for_each = each.value.data_location_arn != null ? [1] : []
    content {
      arn        = each.value.data_location_arn
      catalog_id = each.value.catalog_id
    }
  }
}
