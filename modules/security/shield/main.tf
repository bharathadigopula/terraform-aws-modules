#==============================================================================
# SHIELD SUBSCRIPTION
#==============================================================================
resource "aws_shield_subscription" "this" {
  count      = var.enable_subscription ? 1 : 0
  auto_renew = var.auto_renew
}

#==============================================================================
# SHIELD PROTECTION
#==============================================================================
resource "aws_shield_protection" "this" {
  for_each = { for p in var.protections : p.name => p }

  name         = each.value.name
  resource_arn = each.value.resource_arn

  tags = merge(var.tags, each.value.tags)

  depends_on = [aws_shield_subscription.this]
}

#==============================================================================
# SHIELD PROTECTION GROUP
#==============================================================================
resource "aws_shield_protection_group" "this" {
  for_each = { for g in var.protection_groups : g.id => g }

  protection_group_id = each.value.id
  aggregation         = each.value.aggregation
  pattern             = each.value.pattern
  resource_type       = each.value.pattern == "BY_RESOURCE_TYPE" ? each.value.resource_type : null
  members             = each.value.pattern == "ARBITRARY" ? each.value.members : null

  tags = merge(var.tags, each.value.tags)

  depends_on = [aws_shield_subscription.this]
}
