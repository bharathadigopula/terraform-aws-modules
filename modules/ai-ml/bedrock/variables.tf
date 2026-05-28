#==============================================================================
# BEDROCK LOGGING VARIABLES
#==============================================================================

variable "model_invocation_logging_config" {
  description = "Bedrock model invocation logging configuration"
  type = object({
    embedding_data_delivery_enabled = optional(bool)
    image_data_delivery_enabled     = optional(bool)
    text_data_delivery_enabled      = optional(bool)
    video_data_delivery_enabled     = optional(bool)
    cloudwatch_config = optional(object({
      log_group_name = string
      role_arn       = string
      large_data_delivery_s3_config = optional(object({
        bucket_name = string
        key_prefix  = optional(string)
      }))
    }))
    s3_config = optional(object({
      bucket_name = string
      key_prefix  = optional(string)
    }))
  })
  default = null
}

#==============================================================================
# BEDROCK GUARDRAIL VARIABLES
#==============================================================================

variable "guardrails" {
  description = "List of Bedrock guardrails to create"
  type = list(object({
    name                      = string
    blocked_input_messaging   = string
    blocked_outputs_messaging = string
    description               = optional(string)
    kms_key_arn               = optional(string)
    content_filters = optional(list(object({
      type              = string
      input_strength    = string
      output_strength   = string
      input_action      = optional(string)
      output_action     = optional(string)
      input_enabled     = optional(bool)
      output_enabled    = optional(bool)
      input_modalities  = optional(list(string))
      output_modalities = optional(list(string))
    })), [])
    topics = optional(list(object({
      name       = string
      type       = string
      definition = string
      examples   = optional(list(string))
    })), [])
    words = optional(list(object({
      text           = string
      input_action   = optional(string)
      output_action  = optional(string)
      input_enabled  = optional(bool)
      output_enabled = optional(bool)
    })), [])
    managed_word_lists = optional(list(object({
      type           = string
      input_action   = optional(string)
      output_action  = optional(string)
      input_enabled  = optional(bool)
      output_enabled = optional(bool)
    })), [])
    tags = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# BEDROCK AGENT VARIABLES
#==============================================================================

variable "agents" {
  description = "List of Bedrock agents to create"
  type = list(object({
    name                        = string
    agent_resource_role_arn     = string
    foundation_model            = string
    instruction                 = optional(string)
    description                 = optional(string)
    idle_session_ttl_in_seconds = optional(number)
    customer_encryption_key_arn = optional(string)
    prepare_agent               = optional(bool)
    skip_resource_in_use_check  = optional(bool)
    agent_collaboration         = optional(string)
    guardrail_configuration = list(object({
      guardrail_identifier = string
      guardrail_version    = string
    }))
    tags = optional(map(string), {})
  }))
  default = []

  validation {
    condition     = alltrue([for agent in var.agents : length(agent.guardrail_configuration) > 0])
    error_message = "Each Bedrock agent must include at least one guardrail configuration."
  }
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================

variable "tags" {
  description = "Tags to apply to all supported resources"
  type        = map(string)
  default     = {}
}
