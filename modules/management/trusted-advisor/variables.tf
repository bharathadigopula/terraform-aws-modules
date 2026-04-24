#==============================================================================
# TRUSTED ADVISOR EVENT RULE VARIABLES
#==============================================================================
variable "event_rules" {
  description = "List of EventBridge rules to capture Trusted Advisor check events"
  type = list(object({
    name            = string
    description     = optional(string, "Managed by Terraform")
    event_pattern   = string
    target_id       = string
    target_arn      = string
    target_role_arn = optional(string)
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
