#==============================================================================
# TEXTRACT VARIABLES
#==============================================================================

variable "resources" {
  description = "List of Textract Cloud Control resources to create"
  type = list(object({
    name            = string
    type_name       = string
    desired_state   = any
    role_arn        = optional(string)
    type_version_id = optional(string)
    timeouts = optional(object({
      create = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = []
}
