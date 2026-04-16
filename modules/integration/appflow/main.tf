#==============================================================================
# APPFLOW FLOW
#==============================================================================
resource "aws_appflow_flow" "this" {
  name        = var.name
  description = var.description
  kms_arn     = var.kms_arn

  source_flow_config {
    connector_type         = var.source_connector_type
    connector_profile_name = var.source_connector_profile_name

    source_connector_properties {
      dynamic "s3" {
        for_each = var.source_connector_type == "S3" ? [var.source_s3_config] : []
        content {
          bucket_name   = s3.value.bucket_name
          bucket_prefix = s3.value.bucket_prefix
        }
      }

      dynamic "salesforce" {
        for_each = var.source_connector_type == "Salesforce" ? [var.source_salesforce_config] : []
        content {
          object                      = salesforce.value.object
          enable_dynamic_field_update = salesforce.value.enable_dynamic_field_update
          include_deleted_records     = salesforce.value.include_deleted_records
        }
      }
    }
  }

  destination_flow_config {
    connector_type         = var.destination_connector_type
    connector_profile_name = var.destination_connector_profile_name

    destination_connector_properties {
      dynamic "s3" {
        for_each = var.destination_connector_type == "S3" ? [var.destination_s3_config] : []
        content {
          bucket_name   = s3.value.bucket_name
          bucket_prefix = s3.value.bucket_prefix

          s3_output_format_config {
            file_type                   = s3.value.file_type
            preserve_source_data_typing = s3.value.preserve_source_data_typing

            aggregation_config {
              aggregation_type = s3.value.aggregation_type
            }
          }
        }
      }
    }
  }

  dynamic "task" {
    for_each = var.tasks
    content {
      task_type     = task.value.task_type
      source_fields = task.value.source_fields

      dynamic "connector_operator" {
        for_each = task.value.connector_operator != null ? [task.value.connector_operator] : []
        content {
          s3         = connector_operator.value.s3
          salesforce = connector_operator.value.salesforce
        }
      }

      destination_field = task.value.destination_field
      task_properties   = task.value.task_properties
    }
  }

  trigger_config {
    trigger_type = var.trigger_type

    dynamic "trigger_properties" {
      for_each = var.trigger_type == "Scheduled" ? [var.schedule_config] : []
      content {
        scheduled {
          schedule_expression = trigger_properties.value.schedule_expression
          data_pull_mode      = trigger_properties.value.data_pull_mode
          schedule_start_time = trigger_properties.value.schedule_start_time
          schedule_end_time   = trigger_properties.value.schedule_end_time
          timezone            = trigger_properties.value.timezone
        }
      }
    }
  }

  tags = var.tags
}
