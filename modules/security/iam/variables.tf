#==============================================================================
# IAM ROLE VARIABLES
#==============================================================================
variable "roles" {
  description = "List of IAM roles to create"
  type = list(object({
    name                    = string
    assume_role_policy      = string
    description             = optional(string, "")
    path                    = optional(string, "/")
    max_session_duration    = optional(number, 3600)
    force_detach_policies   = optional(bool, false)
    permissions_boundary    = optional(string)
    managed_policy_arns     = optional(list(string), [])
    inline_policies         = optional(map(string), {})
    create_instance_profile = optional(bool, false)
    tags                    = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# IAM POLICY VARIABLES
#==============================================================================
variable "policies" {
  description = "List of IAM policies to create"
  type = list(object({
    name        = string
    policy      = string
    description = optional(string, "")
    path        = optional(string, "/")
    tags        = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# IAM USER VARIABLES
#==============================================================================
variable "users" {
  description = "List of IAM users to create"
  type = list(object({
    name                 = string
    path                 = optional(string, "/")
    force_destroy        = optional(bool, false)
    permissions_boundary = optional(string)
    policy_arns          = optional(list(string), [])
    tags                 = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# IAM GROUP VARIABLES
#==============================================================================
variable "groups" {
  description = "List of IAM groups to create"
  type = list(object({
    name        = string
    path        = optional(string, "/")
    policy_arns = optional(list(string), [])
    user_names  = optional(list(string), [])
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
