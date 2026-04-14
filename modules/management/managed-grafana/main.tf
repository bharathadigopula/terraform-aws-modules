#==============================================================================
# MANAGED GRAFANA WORKSPACE
#==============================================================================
resource "aws_grafana_workspace" "this" {
  name                      = var.name
  description               = var.description
  account_access_type       = var.account_access_type
  authentication_providers  = var.authentication_providers
  permission_type           = var.permission_type
  role_arn                  = var.role_arn
  data_sources              = var.data_sources
  notification_destinations = var.notification_destinations
  organizational_units      = var.organizational_units
  stack_set_name            = var.stack_set_name
  grafana_version           = var.grafana_version

  dynamic "configuration" {
    for_each = var.configuration_json != null ? [1] : []
    content {
      json = var.configuration_json
    }
  }

  tags = var.tags
}

#==============================================================================
# WORKSPACE API KEY
#==============================================================================
resource "aws_grafana_workspace_api_key" "this" {
  for_each = { for k in var.api_keys : k.key_name => k }

  key_name        = each.value.key_name
  key_role        = each.value.key_role
  seconds_to_live = each.value.seconds_to_live
  workspace_id    = aws_grafana_workspace.this.id
}

#==============================================================================
# ROLE ASSOCIATION
#==============================================================================
resource "aws_grafana_role_association" "this" {
  for_each = { for r in var.role_associations : "${r.role}-${join(",", r.user_ids)}${join(",", r.group_ids)}" => r }

  role         = each.value.role
  user_ids     = each.value.user_ids
  group_ids    = each.value.group_ids
  workspace_id = aws_grafana_workspace.this.id
}
