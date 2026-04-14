#==============================================================================
# CLOUDWATCH LOG GROUP
#==============================================================================
resource "aws_cloudwatch_log_group" "this" {
  for_each = { for lg in var.log_groups : lg.name => lg }

  name              = each.value.name
  retention_in_days = each.value.retention_in_days
  kms_key_id        = each.value.kms_key_id
  log_group_class   = each.value.log_group_class
  skip_destroy      = each.value.skip_destroy

  tags = merge(var.tags, each.value.tags)
}

#==============================================================================
# CLOUDWATCH LOG METRIC FILTER
#==============================================================================
resource "aws_cloudwatch_log_metric_filter" "this" {
  for_each = { for f in var.metric_filters : f.name => f }

  name           = each.value.name
  pattern        = each.value.pattern
  log_group_name = aws_cloudwatch_log_group.this[each.value.log_group_name].name

  metric_transformation {
    name          = each.value.metric_name
    namespace     = each.value.metric_namespace
    value         = each.value.metric_value
    default_value = each.value.default_value
  }
}

#==============================================================================
# CLOUDWATCH LOG SUBSCRIPTION FILTER
#==============================================================================
resource "aws_cloudwatch_log_subscription_filter" "this" {
  for_each = { for s in var.subscription_filters : s.name => s }

  name            = each.value.name
  log_group_name  = aws_cloudwatch_log_group.this[each.value.log_group_name].name
  filter_pattern  = each.value.filter_pattern
  destination_arn = each.value.destination_arn
  role_arn        = each.value.role_arn
  distribution    = each.value.distribution
}
