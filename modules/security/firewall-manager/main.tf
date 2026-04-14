#==============================================================================
# FIREWALL MANAGER ADMIN ACCOUNT
#==============================================================================
resource "aws_fms_admin_account" "this" {
  count = var.admin_account_id != null ? 1 : 0

  account_id = var.admin_account_id
}

#==============================================================================
# FIREWALL MANAGER POLICIES
#==============================================================================
resource "aws_fms_policy" "this" {
  for_each = { for p in var.policies : p.name => p }

  name                        = each.value.name
  resource_type               = each.value.resource_type
  resource_type_list          = each.value.resource_type_list
  remediation_enabled         = each.value.remediation_enabled
  delete_all_policy_resources = each.value.delete_all_policy_resources

  exclude_resource_tags = each.value.exclude_resource_tags

  dynamic "include_map" {
    for_each = length(each.value.include_account_ids) > 0 ? [1] : []
    content {
      account = each.value.include_account_ids
    }
  }

  dynamic "exclude_map" {
    for_each = length(each.value.exclude_account_ids) > 0 ? [1] : []
    content {
      account = each.value.exclude_account_ids
    }
  }

  security_service_policy_data {
    type                 = each.value.security_service_type
    managed_service_data = each.value.managed_service_data
  }

  tags = merge(var.tags, each.value.tags)

  depends_on = [aws_fms_admin_account.this]
}
