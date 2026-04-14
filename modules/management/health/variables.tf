#==============================================================================
# HEALTH VARIABLES
#==============================================================================
variable "enable_organizational_view" {
  description = "Whether to enable organizational view for AWS Health"
  type        = bool
  default     = false
}

#==============================================================================
# EVENT RULE VARIABLES
#==============================================================================
variable "event_rules" {
  description = "List of EventBridge rules for Health events"
  type = list(object({
    name            = string
    description     = optional(string, "Managed by Terraform")
    event_pattern   = string
    target_id       = string
    target_arn      = string
    target_role_arn = optional(string)
    input_paths     = optional(map(string))
    input_template  = optional(string)
    tags            = optional(map(string), {})
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
