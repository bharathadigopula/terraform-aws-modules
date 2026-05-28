#==============================================================================
# BEDROCK MODEL INVOCATION LOGGING
#==============================================================================

resource "aws_bedrock_model_invocation_logging_configuration" "this" {
  count = var.model_invocation_logging_config != null ? 1 : 0

  logging_config {
    embedding_data_delivery_enabled = var.model_invocation_logging_config.embedding_data_delivery_enabled
    image_data_delivery_enabled     = var.model_invocation_logging_config.image_data_delivery_enabled
    text_data_delivery_enabled      = var.model_invocation_logging_config.text_data_delivery_enabled
    video_data_delivery_enabled     = var.model_invocation_logging_config.video_data_delivery_enabled

    dynamic "cloudwatch_config" {
      for_each = var.model_invocation_logging_config.cloudwatch_config != null ? [var.model_invocation_logging_config.cloudwatch_config] : []

      content {
        log_group_name = cloudwatch_config.value.log_group_name
        role_arn       = cloudwatch_config.value.role_arn

        dynamic "large_data_delivery_s3_config" {
          for_each = cloudwatch_config.value.large_data_delivery_s3_config != null ? [cloudwatch_config.value.large_data_delivery_s3_config] : []

          content {
            bucket_name = large_data_delivery_s3_config.value.bucket_name
            key_prefix  = large_data_delivery_s3_config.value.key_prefix
          }
        }
      }
    }

    dynamic "s3_config" {
      for_each = var.model_invocation_logging_config.s3_config != null ? [var.model_invocation_logging_config.s3_config] : []

      content {
        bucket_name = s3_config.value.bucket_name
        key_prefix  = s3_config.value.key_prefix
      }
    }
  }
}

#==============================================================================
# BEDROCK GUARDRAILS
#==============================================================================

resource "aws_bedrock_guardrail" "this" {
  for_each = { for guardrail in var.guardrails : guardrail.name => guardrail }

  name                      = each.value.name
  blocked_input_messaging   = each.value.blocked_input_messaging
  blocked_outputs_messaging = each.value.blocked_outputs_messaging
  description               = each.value.description
  kms_key_arn               = each.value.kms_key_arn
  tags                      = merge(var.tags, each.value.tags)

  dynamic "content_policy_config" {
    for_each = length(each.value.content_filters) > 0 ? [each.value.content_filters] : []

    content {
      dynamic "filters_config" {
        for_each = content_policy_config.value

        content {
          type              = filters_config.value.type
          input_strength    = filters_config.value.input_strength
          output_strength   = filters_config.value.output_strength
          input_action      = filters_config.value.input_action
          output_action     = filters_config.value.output_action
          input_enabled     = filters_config.value.input_enabled
          output_enabled    = filters_config.value.output_enabled
          input_modalities  = filters_config.value.input_modalities
          output_modalities = filters_config.value.output_modalities
        }
      }
    }
  }

  dynamic "topic_policy_config" {
    for_each = length(each.value.topics) > 0 ? [each.value.topics] : []

    content {
      dynamic "topics_config" {
        for_each = topic_policy_config.value

        content {
          name       = topics_config.value.name
          type       = topics_config.value.type
          definition = topics_config.value.definition
          examples   = topics_config.value.examples
        }
      }
    }
  }

  dynamic "word_policy_config" {
    for_each = length(each.value.words) > 0 || length(each.value.managed_word_lists) > 0 ? [each.value] : []

    content {
      dynamic "words_config" {
        for_each = word_policy_config.value.words

        content {
          text           = words_config.value.text
          input_action   = words_config.value.input_action
          output_action  = words_config.value.output_action
          input_enabled  = words_config.value.input_enabled
          output_enabled = words_config.value.output_enabled
        }
      }

      dynamic "managed_word_lists_config" {
        for_each = word_policy_config.value.managed_word_lists

        content {
          type           = managed_word_lists_config.value.type
          input_action   = managed_word_lists_config.value.input_action
          output_action  = managed_word_lists_config.value.output_action
          input_enabled  = managed_word_lists_config.value.input_enabled
          output_enabled = managed_word_lists_config.value.output_enabled
        }
      }
    }
  }
}

#==============================================================================
# BEDROCK AGENTS
#==============================================================================

resource "aws_bedrockagent_agent" "this" {
  for_each = { for agent in var.agents : agent.name => agent }

  agent_name                  = each.value.name
  agent_resource_role_arn     = each.value.agent_resource_role_arn
  foundation_model            = each.value.foundation_model
  instruction                 = each.value.instruction
  description                 = each.value.description
  idle_session_ttl_in_seconds = each.value.idle_session_ttl_in_seconds
  customer_encryption_key_arn = each.value.customer_encryption_key_arn
  prepare_agent               = each.value.prepare_agent
  skip_resource_in_use_check  = each.value.skip_resource_in_use_check
  agent_collaboration         = each.value.agent_collaboration
  guardrail_configuration {
    guardrail_identifier = each.value.guardrail_configuration[0].guardrail_identifier
    guardrail_version    = each.value.guardrail_configuration[0].guardrail_version
  }
  tags = merge(var.tags, each.value.tags)
}
