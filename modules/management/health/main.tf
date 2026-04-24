#==============================================================================
# HEALTH EVENT NOTIFICATION VIA EVENTBRIDGE
#==============================================================================
resource "aws_cloudwatch_event_rule" "health" {
  for_each = { for r in var.event_rules : r.name => r }

  name          = each.value.name
  description   = each.value.description
  event_pattern = each.value.event_pattern

  tags = merge(var.tags, each.value.tags)
}

resource "aws_cloudwatch_event_target" "health" {
  for_each = { for r in var.event_rules : r.name => r }

  rule      = aws_cloudwatch_event_rule.health[each.key].name
  target_id = each.value.target_id
  arn       = each.value.target_arn
  role_arn  = each.value.target_role_arn

  dynamic "input_transformer" {
    for_each = each.value.input_template != null ? [1] : []
    content {
      input_paths    = each.value.input_paths
      input_template = each.value.input_template
    }
  }
}
