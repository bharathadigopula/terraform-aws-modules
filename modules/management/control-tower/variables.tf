#==============================================================================
# LANDING ZONE VARIABLES
#==============================================================================
variable "create_landing_zone" {
  description = "Whether to create a Control Tower landing zone"
  type        = bool
  default     = false
}

variable "manifest_json" {
  description = "Landing zone manifest JSON"
  type        = string
  default     = null
}

variable "landing_zone_version" {
  description = "Landing zone version"
  type        = string
  default     = null
}

#==============================================================================
# CONTROL VARIABLES
#==============================================================================
variable "controls" {
  description = "List of Control Tower controls (guardrails) to enable"
  type = list(object({
    control_identifier = string
    target_identifier  = string
    parameters = optional(list(object({
      key   = string
      value = string
    })), [])
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
