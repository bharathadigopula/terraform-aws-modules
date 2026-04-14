#==============================================================================
# IDENTITY CENTER VARIABLES
#==============================================================================
variable "instance_arn" {
  description = "ARN of the IAM Identity Center instance"
  type        = string
}

variable "permission_sets" {
  description = "List of permission sets to create"
  type = list(object({
    name                = string
    description         = optional(string, "")
    session_duration    = optional(string, "PT1H")
    relay_state         = optional(string)
    managed_policy_arns = optional(list(string), [])
    inline_policy       = optional(string)
    tags                = optional(map(string), {})
  }))
  default = []
}

variable "account_assignments" {
  description = "List of account assignments"
  type = list(object({
    permission_set_name = string
    principal_type      = string
    principal_id        = string
    target_id           = string
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
