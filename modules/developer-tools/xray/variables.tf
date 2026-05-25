#==============================================================================
# XRAY ENCRYPTION VARIABLES
#==============================================================================

variable "encryption_config" {
  description = "X-Ray encryption configuration"
  type = object({
    type   = string
    key_id = optional(string)
  })
  default = null
}

#==============================================================================
# XRAY GROUP VARIABLES
#==============================================================================

variable "groups" {
  description = "List of X-Ray groups to create"
  type = list(object({
    name              = string
    filter_expression = string
    insights_configuration = optional(object({
      insights_enabled      = bool
      notifications_enabled = optional(bool)
    }))
    tags = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# XRAY SAMPLING RULE VARIABLES
#==============================================================================

variable "sampling_rules" {
  description = "List of X-Ray sampling rules to create"
  type = list(object({
    name           = string
    priority       = number
    version        = number
    reservoir_size = number
    fixed_rate     = number
    url_path       = string
    host           = string
    http_method    = string
    service_name   = string
    service_type   = string
    resource_arn   = string
    attributes     = optional(map(string))
    tags           = optional(map(string), {})
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
