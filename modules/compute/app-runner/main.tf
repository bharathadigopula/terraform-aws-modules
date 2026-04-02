#==============================================================================
# APP RUNNER AUTO SCALING CONFIGURATION
#==============================================================================

resource "aws_apprunner_auto_scaling_configuration_version" "this" {
  count = var.auto_scaling_configuration != null ? 1 : 0

  auto_scaling_configuration_name = "${var.service_name}-auto-scaling"
  max_concurrency                 = var.auto_scaling_configuration.max_concurrency
  max_size                        = var.auto_scaling_configuration.max_size
  min_size                        = var.auto_scaling_configuration.min_size

  tags = var.tags
}

#==============================================================================
# APP RUNNER SERVICE
#==============================================================================

resource "aws_apprunner_service" "this" {
  service_name = var.service_name

  source_configuration {
    auto_deployments_enabled = var.auto_deployments_enabled

    dynamic "authentication_configuration" {
      for_each = var.access_role_arn != null ? [1] : []

      content {
        access_role_arn = var.access_role_arn
      }
    }

    dynamic "image_repository" {
      for_each = var.source_type == "image" && var.image_repository != null ? [var.image_repository] : []

      content {
        image_identifier      = image_repository.value.image_identifier
        image_repository_type = image_repository.value.image_repository_type

        dynamic "image_configuration" {
          for_each = image_repository.value.image_configuration != null ? [image_repository.value.image_configuration] : []

          content {
            port                          = image_configuration.value.port
            runtime_environment_variables = image_configuration.value.runtime_environment_variables
            start_command                 = image_configuration.value.start_command
          }
        }
      }
    }

    dynamic "code_repository" {
      for_each = var.source_type == "code" && var.code_repository != null ? [var.code_repository] : []

      content {
        repository_url = code_repository.value.repository_url

        source_code_version {
          type  = code_repository.value.source_code_version.type
          value = code_repository.value.source_code_version.value
        }

        code_configuration {
          configuration_source = code_repository.value.code_configuration.configuration_source

          dynamic "code_configuration_values" {
            for_each = code_repository.value.code_configuration.configuration_source == "API" ? [code_repository.value.code_configuration] : []

            content {
              runtime                       = code_configuration_values.value.runtime
              build_command                 = code_configuration_values.value.build_command
              port                          = code_configuration_values.value.port
              start_command                 = code_configuration_values.value.start_command
              runtime_environment_variables = code_configuration_values.value.runtime_environment_variables
            }
          }
        }
      }
    }
  }

  dynamic "health_check_configuration" {
    for_each = var.health_check_configuration != null ? [var.health_check_configuration] : []

    content {
      protocol            = health_check_configuration.value.protocol
      path                = health_check_configuration.value.path
      interval            = health_check_configuration.value.interval
      timeout             = health_check_configuration.value.timeout
      healthy_threshold   = health_check_configuration.value.healthy_threshold
      unhealthy_threshold = health_check_configuration.value.unhealthy_threshold
    }
  }

  dynamic "instance_configuration" {
    for_each = var.instance_configuration != null ? [var.instance_configuration] : []

    content {
      cpu               = instance_configuration.value.cpu
      memory            = instance_configuration.value.memory
      instance_role_arn = instance_configuration.value.instance_role_arn
    }
  }

  dynamic "network_configuration" {
    for_each = var.vpc_connector_arn != null ? [1] : []

    content {
      egress_configuration {
        egress_type       = "VPC"
        vpc_connector_arn = var.vpc_connector_arn
      }
    }
  }

  dynamic "encryption_configuration" {
    for_each = var.encryption_kms_key != null ? [1] : []

    content {
      kms_key = var.encryption_kms_key
    }
  }

  dynamic "observability_configuration" {
    for_each = var.observability_enabled ? [1] : []

    content {
      observability_enabled = true
    }
  }

  auto_scaling_configuration_arn = var.auto_scaling_configuration != null ? aws_apprunner_auto_scaling_configuration_version.this[0].arn : null

  tags = var.tags
}
