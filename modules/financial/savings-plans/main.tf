#==============================================================================
# SAVINGS PLANS
#==============================================================================

resource "aws_savingsplans_savings_plan" "this" {
  for_each = { for plan in var.savings_plans : plan.name => plan }

  savings_plan_offering_id = each.value.savings_plan_offering_id
  commitment               = each.value.commitment
  upfront_payment_amount   = each.value.upfront_payment_amount
  purchase_time            = each.value.purchase_time
  tags                     = merge(var.tags, each.value.tags)

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []

    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
    }
  }
}
