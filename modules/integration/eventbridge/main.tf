#==============================================================================
# EVENTBRIDGE BUS
#==============================================================================
resource "aws_cloudwatch_event_bus" "this" {
  count = var.create_bus ? 1 : 0

  name              = var.bus_name
  event_source_name = var.event_source_name

  tags = var.tags
}

#==============================================================================
# EVENTBRIDGE RULES
#==============================================================================
resource "aws_cloudwatch_event_rule" "this" {
  for_each = { for r in var.rules : r.name => r }

  name                = each.value.name
  description         = each.value.description
  event_bus_name      = var.create_bus ? aws_cloudwatch_event_bus.this[0].name : each.value.event_bus_name
  schedule_expression = each.value.schedule_expression
  event_pattern       = each.value.event_pattern
  state               = each.value.state
  role_arn            = each.value.role_arn

  tags = merge(var.tags, each.value.tags)
}

#==============================================================================
# EVENTBRIDGE TARGETS
#==============================================================================
resource "aws_cloudwatch_event_target" "this" {
  for_each = {
    for item in flatten([
      for r in var.rules : [
        for t in r.targets : {
          key            = "${r.name}-${t.target_id}"
          rule_name      = r.name
          target_id      = t.target_id
          arn            = t.arn
          role_arn       = t.role_arn
          input          = t.input
          input_path     = t.input_path
          event_bus_name = r.event_bus_name
        }
      ]
    ]) : item.key => item
  }

  rule           = aws_cloudwatch_event_rule.this[each.value.rule_name].name
  event_bus_name = var.create_bus ? aws_cloudwatch_event_bus.this[0].name : each.value.event_bus_name
  target_id      = each.value.target_id
  arn            = each.value.arn
  role_arn       = each.value.role_arn
  input          = each.value.input
  input_path     = each.value.input_path
}

#==============================================================================
# EVENTBRIDGE ARCHIVE
#==============================================================================
resource "aws_cloudwatch_event_archive" "this" {
  for_each = { for a in var.archives : a.name => a }

  name             = each.value.name
  description      = each.value.description
  event_source_arn = var.create_bus ? aws_cloudwatch_event_bus.this[0].arn : each.value.event_source_arn
  retention_days   = each.value.retention_days
  event_pattern    = each.value.event_pattern
}

#==============================================================================
# EVENTBRIDGE PERMISSION
#==============================================================================
resource "aws_cloudwatch_event_permission" "this" {
  for_each = { for p in var.permissions : p.statement_id => p }

  principal      = each.value.principal
  statement_id   = each.value.statement_id
  action         = each.value.action
  event_bus_name = var.create_bus ? aws_cloudwatch_event_bus.this[0].name : each.value.event_bus_name
}
