#==============================================================================
# BUDGETS
#==============================================================================

resource "aws_budgets_budget" "this" {
  for_each = { for budget in var.budgets : budget.name => budget }

  name              = each.value.name
  name_prefix       = each.value.name_prefix
  budget_type       = each.value.budget_type
  limit_amount      = each.value.limit_amount
  limit_unit        = each.value.limit_unit
  time_unit         = each.value.time_unit
  time_period_start = each.value.time_period_start
  time_period_end   = each.value.time_period_end
  account_id        = each.value.account_id
  billing_view_arn  = each.value.billing_view_arn
  tags              = merge(var.tags, each.value.tags)

  dynamic "cost_filter" {
    for_each = each.value.cost_filters

    content {
      name   = cost_filter.value.name
      values = cost_filter.value.values
    }
  }

  dynamic "cost_types" {
    for_each = each.value.cost_types != null ? [each.value.cost_types] : []

    content {
      include_credit             = cost_types.value.include_credit
      include_discount           = cost_types.value.include_discount
      include_other_subscription = cost_types.value.include_other_subscription
      include_recurring          = cost_types.value.include_recurring
      include_refund             = cost_types.value.include_refund
      include_subscription       = cost_types.value.include_subscription
      include_support            = cost_types.value.include_support
      include_tax                = cost_types.value.include_tax
      include_upfront            = cost_types.value.include_upfront
      use_amortized              = cost_types.value.use_amortized
      use_blended                = cost_types.value.use_blended
    }
  }

  dynamic "planned_limit" {
    for_each = each.value.planned_limits

    content {
      amount     = planned_limit.value.amount
      start_time = planned_limit.value.start_time
      unit       = planned_limit.value.unit
    }
  }

  dynamic "notification" {
    for_each = each.value.notifications

    content {
      comparison_operator        = notification.value.comparison_operator
      notification_type          = notification.value.notification_type
      threshold                  = notification.value.threshold
      threshold_type             = notification.value.threshold_type
      subscriber_email_addresses = notification.value.subscriber_email_addresses
      subscriber_sns_topic_arns  = notification.value.subscriber_sns_topic_arns
    }
  }
}
