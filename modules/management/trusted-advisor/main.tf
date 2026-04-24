#==============================================================================
# TRUSTED ADVISOR EVENT RULES
#==============================================================================
resource "aws_cloudwatch_event_rule" "this" {
  for_each = { for r in var.event_rules : r.name => r }

  name          = each.value.name
  description   = each.value.description
  event_pattern = each.value.event_pattern

  tags = merge(var.tags, each.value.tags)
}

#==============================================================================
# TRUSTED ADVISOR EVENT TARGETS
#==============================================================================
resource "aws_cloudwatch_event_target" "this" {
  for_each = { for r in var.event_rules : r.name => r }

  rule      = aws_cloudwatch_event_rule.this[each.key].name
  target_id = each.value.target_id
  arn       = each.value.target_arn
  role_arn  = each.value.target_role_arn
}
