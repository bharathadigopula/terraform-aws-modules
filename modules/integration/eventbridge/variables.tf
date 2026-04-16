#==============================================================================
# BUS VARIABLES
#==============================================================================
variable "create_bus" {
  description = "Whether to create a custom event bus"
  type        = bool
  default     = true
}

variable "bus_name" {
  description = "Name of the event bus"
  type        = string
  default     = "default"
}

variable "event_source_name" {
  description = "Partner event source name"
  type        = string
  default     = null
}

#==============================================================================
# RULE VARIABLES
#==============================================================================
variable "rules" {
  description = "List of EventBridge rules"
  type = list(object({
    name                = string
    description         = optional(string, "Managed by Terraform")
    event_bus_name      = optional(string, "default")
    schedule_expression = optional(string)
    event_pattern       = optional(string)
    state               = optional(string, "ENABLED")
    role_arn            = optional(string)
    tags                = optional(map(string), {})
    targets = optional(list(object({
      target_id  = string
      arn        = string
      role_arn   = optional(string)
      input      = optional(string)
      input_path = optional(string)
    })), [])
  }))
  default = []
}

#==============================================================================
# ARCHIVE VARIABLES
#==============================================================================
variable "archives" {
  description = "List of event archives"
  type = list(object({
    name             = string
    description      = optional(string, "Managed by Terraform")
    event_source_arn = optional(string)
    retention_days   = optional(number, 0)
    event_pattern    = optional(string)
  }))
  default = []
}

#==============================================================================
# PERMISSION VARIABLES
#==============================================================================
variable "permissions" {
  description = "List of event bus permissions"
  type = list(object({
    principal      = string
    statement_id   = string
    action         = optional(string, "events:PutEvents")
    event_bus_name = optional(string, "default")
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
