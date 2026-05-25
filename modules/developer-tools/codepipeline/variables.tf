#==============================================================================
# CODEPIPELINE VARIABLES
#==============================================================================

variable "pipelines" {
  description = "List of CodePipeline pipelines to create"
  type = list(object({
    name           = string
    role_arn       = string
    pipeline_type  = optional(string)
    execution_mode = optional(string)
    artifact_stores = list(object({
      location = string
      type     = string
      region   = optional(string)
      encryption_key = optional(object({
        id   = string
        type = string
      }))
    }))
    stages = list(object({
      name = string
      actions = list(object({
        name               = string
        category           = string
        owner              = string
        provider           = string
        version            = string
        configuration      = optional(map(string), {})
        input_artifacts    = optional(list(string), [])
        output_artifacts   = optional(list(string), [])
        namespace          = optional(string)
        region             = optional(string)
        role_arn           = optional(string)
        run_order          = optional(number)
        timeout_in_minutes = optional(number)
      }))
    }))
    variables = optional(list(object({
      name          = string
      default_value = optional(string)
      description   = optional(string)
    })), [])
    tags = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================

variable "tags" {
  description = "Tags to apply to all supported resources"
  type        = map(string)
  default     = {}
}
