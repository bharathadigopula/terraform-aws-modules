#==============================================================================
# AMAZON MQ BROKER
#==============================================================================
resource "aws_mq_broker" "this" {
  broker_name                = var.broker_name
  engine_type                = var.engine_type
  engine_version             = var.engine_version
  host_instance_type         = var.host_instance_type
  deployment_mode            = var.deployment_mode
  publicly_accessible        = var.publicly_accessible
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  apply_immediately          = var.apply_immediately
  subnet_ids                 = var.subnet_ids
  security_groups            = var.security_groups
  authentication_strategy    = var.authentication_strategy

  dynamic "encryption_options" {
    for_each = var.kms_key_id != null ? [1] : []
    content {
      kms_key_id        = var.kms_key_id
      use_aws_owned_key = false
    }
  }

  dynamic "user" {
    for_each = { for u in var.users : u.username => u }
    content {
      username       = user.value.username
      password       = user.value.password
      console_access = user.value.console_access
      groups         = user.value.groups
    }
  }

  dynamic "logs" {
    for_each = var.engine_type == "ActiveMQ" ? [1] : []
    content {
      general = var.general_log_enabled
      audit   = var.audit_log_enabled
    }
  }

  dynamic "logs" {
    for_each = var.engine_type == "RabbitMQ" ? [1] : []
    content {
      general = var.general_log_enabled
    }
  }

  maintenance_window_start_time {
    day_of_week = var.maintenance_day_of_week
    time_of_day = var.maintenance_time_of_day
    time_zone   = var.maintenance_time_zone
  }

  tags = var.tags
}

#==============================================================================
# MQ CONFIGURATION
#==============================================================================
resource "aws_mq_configuration" "this" {
  count = var.configuration_data != null ? 1 : 0

  name           = "${var.broker_name}-config"
  description    = "Configuration for ${var.broker_name}"
  engine_type    = var.engine_type
  engine_version = var.engine_version
  data           = var.configuration_data

  tags = var.tags
}
