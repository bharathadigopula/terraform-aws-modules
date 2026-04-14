#==============================================================================
# SHIELD SUBSCRIPTION VARIABLES
#==============================================================================
variable "enable_subscription" {
  description = "Whether to enable Shield Advanced subscription"
  type        = bool
  default     = false
}

variable "auto_renew" {
  description = "Whether to auto-renew the Shield Advanced subscription"
  type        = string
  default     = "ENABLED"
}

#==============================================================================
# SHIELD PROTECTION VARIABLES
#==============================================================================
variable "protections" {
  description = "List of resources to protect with Shield Advanced"
  type = list(object({
    name         = string
    resource_arn = string
    tags         = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# PROTECTION GROUP VARIABLES
#==============================================================================
variable "protection_groups" {
  description = "List of Shield protection groups"
  type = list(object({
    id            = string
    aggregation   = string
    pattern       = string
    resource_type = optional(string)
    members       = optional(list(string), [])
    tags          = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
