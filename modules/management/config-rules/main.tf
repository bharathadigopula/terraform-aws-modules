#==============================================================================
# AWS CONFIG CONFIGURATION RECORDER
#==============================================================================
resource "aws_config_configuration_recorder" "this" {
  count = var.create_recorder ? 1 : 0

  name     = var.recorder_name
  role_arn = var.recorder_role_arn

  recording_group {
    all_supported                 = var.recording_all_supported
    include_global_resource_types = var.include_global_resource_types
    resource_types                = var.recording_resource_types
  }

  recording_mode {
    recording_frequency = var.recording_frequency
  }
}

#==============================================================================
# CONFIG RECORDER STATUS
#==============================================================================
resource "aws_config_configuration_recorder_status" "this" {
  count = var.create_recorder ? 1 : 0

  name       = aws_config_configuration_recorder.this[0].name
  is_enabled = var.recorder_enabled
}

#==============================================================================
# CONFIG DELIVERY CHANNEL
#==============================================================================
resource "aws_config_delivery_channel" "this" {
  count = var.create_recorder ? 1 : 0

  name           = var.delivery_channel_name
  s3_bucket_name = var.delivery_s3_bucket
  s3_key_prefix  = var.delivery_s3_key_prefix
  sns_topic_arn  = var.delivery_sns_topic_arn

  snapshot_delivery_properties {
    delivery_frequency = var.delivery_frequency
  }

  depends_on = [aws_config_configuration_recorder.this]
}

#==============================================================================
# AWS CONFIG RULES
#==============================================================================
resource "aws_config_config_rule" "managed" {
  for_each = { for r in var.managed_rules : r.name => r }

  name                        = each.value.name
  description                 = each.value.description
  maximum_execution_frequency = each.value.maximum_execution_frequency

  source {
    owner             = "AWS"
    source_identifier = each.value.source_identifier
  }

  input_parameters = each.value.input_parameters

  dynamic "scope" {
    for_each = each.value.resource_types != null ? [1] : []
    content {
      compliance_resource_types = each.value.resource_types
    }
  }

  tags = merge(var.tags, each.value.tags)

  depends_on = [aws_config_configuration_recorder.this]
}

#==============================================================================
# CUSTOM CONFIG RULES (LAMBDA)
#==============================================================================
resource "aws_config_config_rule" "custom" {
  for_each = { for r in var.custom_rules : r.name => r }

  name                        = each.value.name
  description                 = each.value.description
  maximum_execution_frequency = each.value.maximum_execution_frequency

  source {
    owner             = "CUSTOM_LAMBDA"
    source_identifier = each.value.lambda_function_arn

    dynamic "source_detail" {
      for_each = each.value.source_details
      content {
        event_source = source_detail.value.event_source
        message_type = source_detail.value.message_type
      }
    }
  }

  input_parameters = each.value.input_parameters

  dynamic "scope" {
    for_each = each.value.resource_types != null ? [1] : []
    content {
      compliance_resource_types = each.value.resource_types
    }
  }

  tags = merge(var.tags, each.value.tags)

  depends_on = [aws_config_configuration_recorder.this]
}
