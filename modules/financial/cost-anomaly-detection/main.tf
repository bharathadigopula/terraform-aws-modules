#==============================================================================
# COST ANOMALY MONITORS
#==============================================================================

resource "aws_ce_anomaly_monitor" "this" {
  for_each = { for monitor in var.monitors : monitor.name => monitor }

  name                  = each.value.name
  monitor_type          = each.value.monitor_type
  monitor_dimension     = each.value.monitor_dimension
  monitor_specification = each.value.monitor_specification
  tags                  = merge(var.tags, each.value.tags)
}

#==============================================================================
# COST ANOMALY SUBSCRIPTIONS
#==============================================================================

resource "aws_ce_anomaly_subscription" "this" {
  for_each = { for subscription in var.subscriptions : subscription.name => subscription }

  name             = each.value.name
  frequency        = each.value.frequency
  monitor_arn_list = concat(each.value.monitor_arn_list, [for monitor_name in each.value.monitor_names : aws_ce_anomaly_monitor.this[monitor_name].arn])
  account_id       = each.value.account_id
  tags             = merge(var.tags, each.value.tags)

  dynamic "subscriber" {
    for_each = each.value.subscribers

    content {
      type    = subscriber.value.type
      address = subscriber.value.address
    }
  }
}
