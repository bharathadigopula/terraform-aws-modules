#==============================================================================
# GLOBAL ACCELERATOR
#==============================================================================

resource "aws_globalaccelerator_accelerator" "this" {
  name            = var.name
  enabled         = var.enabled
  ip_address_type = var.ip_address_type
  ip_addresses    = length(var.ip_addresses) > 0 ? var.ip_addresses : null

  attributes {
    flow_logs_enabled   = var.flow_logs_enabled
    flow_logs_s3_bucket = var.flow_logs_s3_bucket
    flow_logs_s3_prefix = var.flow_logs_s3_prefix
  }

  tags = var.tags
}

#==============================================================================
# LISTENERS
#==============================================================================

resource "aws_globalaccelerator_listener" "this" {
  count = length(var.listeners)

  accelerator_arn = aws_globalaccelerator_accelerator.this.id
  protocol        = var.listeners[count.index].protocol
  client_affinity = var.listeners[count.index].client_affinity

  dynamic "port_range" {
    for_each = var.listeners[count.index].port_ranges

    content {
      from_port = port_range.value.from_port
      to_port   = port_range.value.to_port
    }
  }
}

#==============================================================================
# ENDPOINT GROUPS
#==============================================================================

resource "aws_globalaccelerator_endpoint_group" "this" {
  count = length(var.endpoint_groups)

  listener_arn                  = aws_globalaccelerator_listener.this[var.endpoint_groups[count.index].listener_index].id
  endpoint_group_region         = var.endpoint_groups[count.index].endpoint_group_region
  health_check_port             = var.endpoint_groups[count.index].health_check_port
  health_check_protocol         = var.endpoint_groups[count.index].health_check_protocol
  health_check_path             = var.endpoint_groups[count.index].health_check_path
  health_check_interval_seconds = var.endpoint_groups[count.index].health_check_interval_seconds
  threshold_count               = var.endpoint_groups[count.index].threshold_count
  traffic_dial_percentage       = var.endpoint_groups[count.index].traffic_dial_percentage

  dynamic "endpoint_configuration" {
    for_each = var.endpoint_groups[count.index].endpoint_configurations

    content {
      endpoint_id                    = endpoint_configuration.value.endpoint_id
      weight                         = endpoint_configuration.value.weight
      client_ip_preservation_enabled = endpoint_configuration.value.client_ip_preservation_enabled
    }
  }
}
