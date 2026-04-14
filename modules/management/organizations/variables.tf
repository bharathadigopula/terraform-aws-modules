#==============================================================================
# ORGANIZATION VARIABLES
#==============================================================================
variable "create_organization" {
  description = "Whether to create a new AWS Organization"
  type        = bool
  default     = true
}

variable "feature_set" {
  description = "Feature set of the organization (ALL or CONSOLIDATED_BILLING)"
  type        = string
  default     = "ALL"
}

variable "aws_service_access_principals" {
  description = "List of AWS service principals to enable integration with"
  type        = list(string)
  default     = []
}

variable "enabled_policy_types" {
  description = "List of policy types to enable (SERVICE_CONTROL_POLICY, TAG_POLICY, etc.)"
  type        = list(string)
  default     = ["SERVICE_CONTROL_POLICY"]
}

variable "root_id" {
  description = "Root ID if not creating the organization (used as parent for OUs)"
  type        = string
  default     = null
}

#==============================================================================
# ORGANIZATIONAL UNIT VARIABLES
#==============================================================================
variable "organizational_units" {
  description = "List of organizational units to create"
  type = list(object({
    name      = string
    parent_id = optional(string)
    tags      = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# ACCOUNT VARIABLES
#==============================================================================
variable "accounts" {
  description = "List of member accounts to create"
  type = list(object({
    name                       = string
    email                      = string
    parent_id                  = optional(string)
    role_name                  = optional(string, "OrganizationAccountAccessRole")
    iam_user_access_to_billing = optional(string, "ALLOW")
    close_on_deletion          = optional(bool, false)
    tags                       = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# POLICY VARIABLES
#==============================================================================
variable "policies" {
  description = "List of organization policies (SCPs, tag policies, etc.)"
  type = list(object({
    name        = string
    description = optional(string, "Managed by Terraform")
    type        = optional(string, "SERVICE_CONTROL_POLICY")
    content     = string
    target_ids  = optional(list(string), [])
    tags        = optional(map(string), {})
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
