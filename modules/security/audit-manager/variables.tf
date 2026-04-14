#==============================================================================
# ACCOUNT REGISTRATION VARIABLES
#==============================================================================
variable "kms_key_arn" {
  description = "KMS key ARN for Audit Manager encryption"
  type        = string
  default     = null
}

variable "delegated_admin_account" {
  description = "Delegated admin account ID"
  type        = string
  default     = null
}

#==============================================================================
# FRAMEWORK VARIABLES
#==============================================================================
variable "frameworks" {
  description = "List of custom Audit Manager frameworks"
  type = list(object({
    name            = string
    description     = optional(string, "")
    compliance_type = optional(string)
    control_sets = list(object({
      name        = string
      control_ids = list(string)
    }))
    tags = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# ASSESSMENT VARIABLES
#==============================================================================
variable "assessments" {
  description = "List of Audit Manager assessments"
  type = list(object({
    name                   = string
    description            = optional(string, "")
    framework_id           = string
    role_arn               = string
    role_type              = optional(string, "PROCESS_OWNER")
    aws_account_ids        = list(string)
    aws_services           = list(string)
    reports_s3_destination = string
    tags                   = optional(map(string), {})
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
