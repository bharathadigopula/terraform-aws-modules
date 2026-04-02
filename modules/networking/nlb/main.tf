#==============================================================================
# NETWORK LOAD BALANCER
#==============================================================================

resource "aws_lb" "this" {
  name               = var.name
  load_balancer_type = "network"
  internal           = var.internal

  subnets                          = length(var.subnet_mappings) > 0 ? null : var.subnets
  enable_deletion_protection       = var.enable_deletion_protection
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing

  dynamic "subnet_mapping" {
    for_each = var.subnet_mappings
    content {
      subnet_id            = subnet_mapping.value.subnet_id
      allocation_id        = subnet_mapping.value.allocation_id
      private_ipv4_address = subnet_mapping.value.private_ipv4_address
    }
  }

  dynamic "access_logs" {
    for_each = var.access_logs != null ? [var.access_logs] : []
    content {
      bucket  = access_logs.value.bucket
      prefix  = access_logs.value.prefix
      enabled = access_logs.value.enabled
    }
  }

  tags = var.tags
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
  vpc_id               = data.aws_lb.current.vpc_id
  deregistration_delay = var.target_groups[count.index].deregistration_delay
  preserve_client_ip   = var.target_groups[count.index].preserve_client_ip

  health_check {
    enabled             = var.target_groups[count.index].health_check.enabled
    protocol            = var.target_groups[count.index].health_check.protocol
    port                = var.target_groups[count.index].health_check.port
    path                = var.target_groups[count.index].health_check.path
    interval            = var.target_groups[count.index].health_check.interval
    healthy_threshold   = var.target_groups[count.index].health_check.healthy_threshold
    unhealthy_threshold = var.target_groups[count.index].health_check.unhealthy_threshold
  }

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

#==============================================================================
# DATA SOURCE - VPC ID FROM NLB
#==============================================================================

data "aws_lb" "current" {
  arn = aws_lb.this.arn
}

#==============================================================================
# LISTENERS
#==============================================================================

resource "aws_lb_listener" "this" {
  count = length(var.listeners)

  load_balancer_arn = aws_lb.this.arn
  port              = var.listeners[count.index].port
  protocol          = var.listeners[count.index].protocol
  ssl_policy        = var.listeners[count.index].protocol == "TLS" ? var.listeners[count.index].ssl_policy : null
  certificate_arn   = var.listeners[count.index].protocol == "TLS" ? var.listeners[count.index].certificate_arn : null

  default_action {
    type             = var.listeners[count.index].default_action
    target_group_arn = aws_lb_target_group.this[count.index].arn
  }

  tags = var.tags
}
