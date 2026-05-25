#==============================================================================
# FIS VARIABLES
#==============================================================================

variable "experiment_templates" {
  description = "List of FIS experiment templates to create"
  type = list(object({
    name        = string
    description = string
    role_arn    = string
    actions = list(object({
      name        = string
      action_id   = string
      description = optional(string)
      start_after = optional(set(string))
      parameters  = optional(map(string), {})
      target = optional(object({
        key   = string
        value = string
      }))
    }))
    targets = optional(list(object({
      name           = string
      resource_type  = string
      selection_mode = string
      resource_arns  = optional(set(string))
      parameters     = optional(map(string))
      filters = optional(list(object({
        path   = string
        values = set(string)
      })), [])
      resource_tags = optional(map(string), {})
    })), [])
    stop_conditions = list(object({
      source = string
      value  = optional(string)
    }))
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
