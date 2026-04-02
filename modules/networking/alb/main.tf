#==============================================================================
# APPLICATION LOAD BALANCER
#==============================================================================

resource "aws_lb" "this" {
  name               = var.name
  load_balancer_type = "application"
  internal           = var.internal
  security_groups    = var.security_groups
  subnets            = var.subnets

  idle_timeout                     = var.idle_timeout
  enable_deletion_protection       = var.enable_deletion_protection
  enable_http2                     = var.enable_http2
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  drop_invalid_header_fields       = var.drop_invalid_header_fields

  dynamic "access_logs" {
    for_each = var.access_logs != null ? [var.access_logs] : []

    content {
      bucket  = access_logs.value.bucket
      prefix  = access_logs.value.prefix
      enabled = access_logs.value.enabled
    }
  }

  tags = merge(var.tags, {
    Name = var.name
  })
}

#==============================================================================
# TARGET GROUPS
#==============================================================================

resource "aws_lb_target_group" "this" {
  count = length(var.target_groups)

  name                 = var.target_groups[count.index].name
  port                 = var.target_groups[count.index].port
  protocol             = var.target_groups[count.index].protocol
  target_type          = var.target_groups[count.index].target_type
  vpc_id               = var.vpc_id
  deregistration_delay = var.target_groups[count.index].deregistration_delay

  dynamic "health_check" {
    for_each = var.target_groups[count.index].health_check != null ? [var.target_groups[count.index].health_check] : []

    content {
      enabled             = health_check.value.enabled
      path                = health_check.value.path
      port                = health_check.value.port
      protocol            = health_check.value.protocol
      healthy_threshold   = health_check.value.healthy_threshold
      unhealthy_threshold = health_check.value.unhealthy_threshold
      timeout             = health_check.value.timeout
      interval            = health_check.value.interval
      matcher             = health_check.value.matcher
    }
  }

  dynamic "stickiness" {
    for_each = var.target_groups[count.index].stickiness != null ? [var.target_groups[count.index].stickiness] : []

    content {
      type            = stickiness.value.type
      enabled         = stickiness.value.enabled
      cookie_duration = stickiness.value.cookie_duration
      cookie_name     = stickiness.value.cookie_name
    }
  }

  tags = merge(var.tags, {
    Name = var.target_groups[count.index].name
  })

  lifecycle {
    create_before_destroy = true
  }
}

#==============================================================================
# LISTENERS
#==============================================================================

resource "aws_lb_listener" "this" {
  count = length(var.listeners)

  load_balancer_arn = aws_lb.this.arn
  port              = var.listeners[count.index].port
  protocol          = var.listeners[count.index].protocol
  ssl_policy        = var.listeners[count.index].protocol == "HTTPS" ? var.listeners[count.index].ssl_policy : null
  certificate_arn   = var.listeners[count.index].protocol == "HTTPS" ? var.listeners[count.index].certificate_arn : null

  default_action {
    type             = var.listeners[count.index].default_action.type
    target_group_arn = var.listeners[count.index].default_action.type == "forward" ? aws_lb_target_group.this[var.listeners[count.index].default_action.target_group_key].arn : null

    dynamic "redirect" {
      for_each = var.listeners[count.index].default_action.type == "redirect" ? [var.listeners[count.index].default_action.redirect] : []

      content {
        port        = redirect.value.port
        protocol    = redirect.value.protocol
        status_code = redirect.value.status_code
      }
    }

    dynamic "fixed_response" {
      for_each = var.listeners[count.index].default_action.type == "fixed-response" ? [var.listeners[count.index].default_action.fixed_response] : []

      content {
        content_type = fixed_response.value.content_type
        message_body = fixed_response.value.message_body
        status_code  = fixed_response.value.status_code
      }
    }
  }

  tags = var.tags
}
