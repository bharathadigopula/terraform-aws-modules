#==============================================================================
# XRAY ENCRYPTION CONFIGURATION
#==============================================================================

resource "aws_xray_encryption_config" "this" {
  count = var.encryption_config != null ? 1 : 0

  type   = var.encryption_config.type
  key_id = var.encryption_config.key_id
}

#==============================================================================
# XRAY GROUPS
#==============================================================================

resource "aws_xray_group" "this" {
  for_each = { for group in var.groups : group.name => group }

  group_name        = each.value.name
  filter_expression = each.value.filter_expression
  tags              = merge(var.tags, each.value.tags)

  dynamic "insights_configuration" {
    for_each = each.value.insights_configuration != null ? [each.value.insights_configuration] : []

    content {
      insights_enabled      = insights_configuration.value.insights_enabled
      notifications_enabled = insights_configuration.value.notifications_enabled
    }
  }
}

#==============================================================================
# XRAY SAMPLING RULES
#==============================================================================

resource "aws_xray_sampling_rule" "this" {
  for_each = { for rule in var.sampling_rules : rule.name => rule }

  rule_name      = each.value.name
  priority       = each.value.priority
  version        = each.value.version
  reservoir_size = each.value.reservoir_size
  fixed_rate     = each.value.fixed_rate
  url_path       = each.value.url_path
  host           = each.value.host
  http_method    = each.value.http_method
  service_name   = each.value.service_name
  service_type   = each.value.service_type
  resource_arn   = each.value.resource_arn
  attributes     = each.value.attributes
  tags           = merge(var.tags, each.value.tags)
}
