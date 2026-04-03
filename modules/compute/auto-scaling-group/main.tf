#==============================================================================
# AUTO SCALING GROUP
#==============================================================================

resource "aws_autoscaling_group" "this" {
  name                      = var.name
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  vpc_zone_identifier       = var.vpc_zone_identifier
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  target_group_arns         = var.target_group_arns
  force_delete              = var.force_delete
  termination_policies      = var.termination_policies
  suspended_processes       = var.suspended_processes
  enabled_metrics           = var.enabled_metrics
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  protect_from_scale_in     = var.protect_from_scale_in
  max_instance_lifetime     = var.max_instance_lifetime > 0 ? var.max_instance_lifetime : null
  capacity_rebalance        = var.capacity_rebalance
  default_cooldown          = var.default_cooldown

  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_version
  }

  #==============================================================================
  # INSTANCE REFRESH
  #==============================================================================

  dynamic "instance_refresh" {
    for_each = var.instance_refresh != null ? [var.instance_refresh] : []

    content {
      strategy = instance_refresh.value.strategy

      dynamic "preferences" {
        for_each = instance_refresh.value.preferences != null ? [instance_refresh.value.preferences] : []

        content {
          min_healthy_percentage = preferences.value.min_healthy_percentage
          instance_warmup        = preferences.value.instance_warmup
          checkpoint_delay       = preferences.value.checkpoint_delay
          checkpoint_percentages = preferences.value.checkpoint_percentages
        }
      }
    }
  }

  #==============================================================================
  # WARM POOL
  #==============================================================================

  dynamic "warm_pool" {
    for_each = var.warm_pool != null ? [var.warm_pool] : []

    content {
      pool_state                  = warm_pool.value.pool_state
      min_size                    = warm_pool.value.min_size
      max_group_prepared_capacity = warm_pool.value.max_group_prepared_capacity

      instance_reuse_policy {
        reuse_on_scale_in = warm_pool.value.reuse_on_scale_in
      }
    }
  }

  #==============================================================================
  # TAGS
  #==============================================================================

  dynamic "tag" {
    for_each = var.tags

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

#==============================================================================
# SCALING POLICIES
#==============================================================================

resource "aws_autoscaling_policy" "this" {
  count = length(var.scaling_policies)

  name                      = var.scaling_policies[count.index].name
  autoscaling_group_name    = aws_autoscaling_group.this.name
  policy_type               = var.scaling_policies[count.index].policy_type
  estimated_instance_warmup = var.scaling_policies[count.index].policy_type == "TargetTrackingScaling" ? var.scaling_policies[count.index].estimated_instance_warmup : null
  cooldown                  = var.scaling_policies[count.index].policy_type == "StepScaling" ? var.scaling_policies[count.index].cooldown : null
  adjustment_type           = var.scaling_policies[count.index].policy_type == "StepScaling" ? "ChangeInCapacity" : null

  dynamic "target_tracking_configuration" {
    for_each = var.scaling_policies[count.index].policy_type == "TargetTrackingScaling" && var.scaling_policies[count.index].target_tracking_configuration != null ? [var.scaling_policies[count.index].target_tracking_configuration] : []

    content {
      predefined_metric_specification {
        predefined_metric_type = target_tracking_configuration.value.predefined_metric_type
      }
      target_value     = target_tracking_configuration.value.target_value
      disable_scale_in = target_tracking_configuration.value.disable_scale_in
    }
  }

  dynamic "step_adjustment" {
    for_each = var.scaling_policies[count.index].policy_type == "StepScaling" && var.scaling_policies[count.index].step_adjustment != null ? var.scaling_policies[count.index].step_adjustment : []

    content {
      scaling_adjustment          = step_adjustment.value.scaling_adjustment
      metric_interval_lower_bound = step_adjustment.value.metric_interval_lower_bound
      metric_interval_upper_bound = step_adjustment.value.metric_interval_upper_bound
    }
  }
}

#==============================================================================
# SCHEDULED ACTIONS
#==============================================================================

resource "aws_autoscaling_schedule" "this" {
  count = length(var.scheduled_actions)

  scheduled_action_name  = var.scheduled_actions[count.index].name
  autoscaling_group_name = aws_autoscaling_group.this.name
  min_size               = var.scheduled_actions[count.index].min_size
  max_size               = var.scheduled_actions[count.index].max_size
  desired_capacity       = var.scheduled_actions[count.index].desired_capacity
  recurrence             = var.scheduled_actions[count.index].recurrence
  start_time             = var.scheduled_actions[count.index].start_time
  end_time               = var.scheduled_actions[count.index].end_time
}
