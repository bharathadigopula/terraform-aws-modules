#==============================================================================
# CODECOMMIT VARIABLES
#==============================================================================

variable "repositories" {
  description = "List of CodeCommit repositories to create"
  type = list(object({
    name           = string
    description    = optional(string)
    default_branch = optional(string)
    kms_key_id     = optional(string)
    triggers = optional(list(object({
      name            = string
      destination_arn = string
      events          = list(string)
      branches        = optional(list(string))
      custom_data     = optional(string)
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
