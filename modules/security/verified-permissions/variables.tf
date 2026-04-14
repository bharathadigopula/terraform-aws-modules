#==============================================================================
# POLICY STORE VARIABLES
#==============================================================================
variable "validation_mode" {
  description = "Validation mode for the policy store (STRICT or OFF)"
  type        = string
  default     = "STRICT"
}

variable "description" {
  description = "Description of the policy store"
  type        = string
  default     = ""
}

#==============================================================================
# SCHEMA VARIABLES
#==============================================================================
variable "schema" {
  description = "Cedar schema definition in JSON format"
  type        = string
  default     = null
}

#==============================================================================
# POLICY VARIABLES
#==============================================================================
variable "static_policies" {
  description = "List of static Cedar policies"
  type = list(object({
    description = string
    statement   = string
  }))
  default = []
}

#==============================================================================
# IDENTITY SOURCE VARIABLES
#==============================================================================
variable "identity_sources" {
  description = "List of identity sources (Cognito User Pools)"
  type = list(object({
    user_pool_arn         = string
    group_entity_type     = optional(string)
    principal_entity_type = optional(string)
  }))
  default = []
}
