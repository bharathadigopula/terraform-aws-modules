#==============================================================================
# MANAGED APACHE FLINK APPLICATION
#==============================================================================
resource "aws_kinesisanalyticsv2_application" "this" {
  name                   = var.name
  description            = var.description
  runtime_environment    = var.runtime_environment
  service_execution_role = var.service_execution_role
  start_application      = var.start_application

  application_configuration {
    application_code_configuration {
      code_content_type = var.code_content_type

      dynamic "code_content" {
        for_each = var.code_content != null ? [var.code_content] : []
        content {
          dynamic "s3_content_location" {
            for_each = code_content.value.s3_bucket_arn != null ? [1] : []
            content {
              bucket_arn     = code_content.value.s3_bucket_arn
              file_key       = code_content.value.s3_file_key
              object_version = code_content.value.s3_object_version
            }
          }
          text_content = code_content.value.text_content
        }
      }
    }

    dynamic "flink_application_configuration" {
      for_each = var.flink_config != null ? [var.flink_config] : []
      content {
        dynamic "checkpoint_configuration" {
          for_each = flink_application_configuration.value.checkpoint_enabled != null ? [1] : []
          content {
            configuration_type            = "CUSTOM"
            checkpointing_enabled         = flink_application_configuration.value.checkpoint_enabled
            checkpoint_interval           = flink_application_configuration.value.checkpoint_interval
            min_pause_between_checkpoints = flink_application_configuration.value.min_pause_between_checkpoints
          }
        }

        dynamic "monitoring_configuration" {
          for_each = flink_application_configuration.value.log_level != null ? [1] : []
          content {
            configuration_type = "CUSTOM"
            log_level          = flink_application_configuration.value.log_level
            metrics_level      = flink_application_configuration.value.metrics_level
          }
        }

        dynamic "parallelism_configuration" {
          for_each = flink_application_configuration.value.parallelism != null ? [1] : []
          content {
            configuration_type   = "CUSTOM"
            parallelism          = flink_application_configuration.value.parallelism
            parallelism_per_kpu  = flink_application_configuration.value.parallelism_per_kpu
            auto_scaling_enabled = flink_application_configuration.value.auto_scaling_enabled
          }
        }
      }
    }

    dynamic "environment_properties" {
      for_each = length(var.property_groups) > 0 ? [1] : []
      content {
        dynamic "property_group" {
          for_each = var.property_groups
          content {
            property_group_id = property_group.value.id
            property_map      = property_group.value.properties
          }
        }
      }
    }
  }

  dynamic "cloudwatch_logging_options" {
    for_each = var.cloudwatch_log_stream_arn != null ? [1] : []
    content {
      log_stream_arn = var.cloudwatch_log_stream_arn
    }
  }

  tags = var.tags
}
