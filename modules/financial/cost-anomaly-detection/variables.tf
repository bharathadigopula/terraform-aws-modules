#==============================================================================
# COST ANOMALY MONITOR VARIABLES
#==============================================================================

variable "monitors" {
  description = "List of Cost Explorer anomaly monitors to create"
  type = list(object({
    name                  = string
    monitor_type          = string
    monitor_dimension     = optional(string)
    monitor_specification = optional(string)
    tags                  = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# COST ANOMALY SUBSCRIPTION VARIABLES
#==============================================================================

variable "subscriptions" {
  description = "List of Cost Explorer anomaly subscriptions to create"
  type = list(object({
    name             = string
    frequency        = string
    monitor_arn_list = optional(list(string), [])
    monitor_names    = optional(list(string), [])
    account_id       = optional(string)
    subscribers = list(object({
      type    = string
      address = string
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
