#==============================================================================
# WORKSPACE VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the Grafana workspace"
  type        = string
}

variable "description" {
  description = "Description of the workspace"
  type        = string
  default     = "Managed by Terraform"
}

variable "account_access_type" {
  description = "Account access type (CURRENT_ACCOUNT or ORGANIZATION)"
  type        = string
  default     = "CURRENT_ACCOUNT"
}

variable "authentication_providers" {
  description = "Authentication providers (AWS_SSO, SAML)"
  type        = list(string)
  default     = ["AWS_SSO"]
}

variable "permission_type" {
  description = "Permission type (SERVICE_MANAGED or CUSTOMER_MANAGED)"
  type        = string
  default     = "SERVICE_MANAGED"
}

variable "role_arn" {
  description = "IAM role ARN for the workspace"
  type        = string
  default     = null
}

variable "data_sources" {
  description = "List of data sources (CLOUDWATCH, PROMETHEUS, XRAY, etc.)"
  type        = list(string)
  default     = ["CLOUDWATCH"]
}

variable "notification_destinations" {
  description = "List of notification destinations (SNS)"
  type        = list(string)
  default     = []
}

variable "organizational_units" {
  description = "List of organizational unit IDs"
  type        = list(string)
  default     = []
}

variable "stack_set_name" {
  description = "AWS CloudFormation stack set name for org access"
  type        = string
  default     = null
}

variable "grafana_version" {
  description = "Grafana version"
  type        = string
  default     = null
}

variable "configuration_json" {
  description = "Workspace configuration JSON"
  type        = string
  default     = null
}

#==============================================================================
# API KEY VARIABLES
#==============================================================================
variable "api_keys" {
  description = "List of workspace API keys"
  type = list(object({
    key_name        = string
    key_role        = string
    seconds_to_live = number
  }))
  default = []
}

#==============================================================================
# ROLE ASSOCIATION VARIABLES
#==============================================================================
variable "role_associations" {
  description = "List of role associations"
  type = list(object({
    role      = string
    user_ids  = optional(list(string), [])
    group_ids = optional(list(string), [])
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
