#==============================================================================
# CODEDEPLOY APPLICATIONS
#==============================================================================

resource "aws_codedeploy_app" "this" {
  for_each = { for app in var.applications : app.name => app }

  name             = each.value.name
  compute_platform = each.value.compute_platform
  tags             = merge(var.tags, each.value.tags)
}

#==============================================================================
# CODEDEPLOY DEPLOYMENT GROUPS
#==============================================================================

resource "aws_codedeploy_deployment_group" "this" {
  for_each = { for group in var.deployment_groups : group.name => group }

  app_name                    = try(aws_codedeploy_app.this[each.value.app_name].name, each.value.app_name)
  deployment_group_name       = each.value.name
  service_role_arn            = each.value.service_role_arn
  deployment_config_name      = each.value.deployment_config_name
  autoscaling_groups          = each.value.autoscaling_groups
  outdated_instances_strategy = each.value.outdated_instances_strategy
  termination_hook_enabled    = each.value.termination_hook_enabled
  tags                        = merge(var.tags, each.value.tags)

  dynamic "deployment_style" {
    for_each = each.value.deployment_style != null ? [each.value.deployment_style] : []

    content {
      deployment_option = deployment_style.value.deployment_option
      deployment_type   = deployment_style.value.deployment_type
    }
  }

  dynamic "alarm_configuration" {
    for_each = each.value.alarm_configuration != null ? [each.value.alarm_configuration] : []

    content {
      alarms                    = alarm_configuration.value.alarms
      enabled                   = alarm_configuration.value.enabled
      ignore_poll_alarm_failure = alarm_configuration.value.ignore_poll_alarm_failure
    }
  }

  dynamic "auto_rollback_configuration" {
    for_each = each.value.auto_rollback_configuration != null ? [each.value.auto_rollback_configuration] : []

    content {
      enabled = auto_rollback_configuration.value.enabled
      events  = auto_rollback_configuration.value.events
    }
  }

  dynamic "ec2_tag_filter" {
    for_each = each.value.ec2_tag_filters

    content {
      key   = ec2_tag_filter.value.key
      type  = ec2_tag_filter.value.type
      value = ec2_tag_filter.value.value
    }
  }

  dynamic "ecs_service" {
    for_each = each.value.ecs_service != null ? [each.value.ecs_service] : []

    content {
      cluster_name = ecs_service.value.cluster_name
      service_name = ecs_service.value.service_name
    }
  }

  dynamic "trigger_configuration" {
    for_each = each.value.trigger_configurations

    content {
      trigger_name       = trigger_configuration.value.trigger_name
      trigger_target_arn = trigger_configuration.value.trigger_target_arn
      trigger_events     = trigger_configuration.value.trigger_events
    }
  }
}
