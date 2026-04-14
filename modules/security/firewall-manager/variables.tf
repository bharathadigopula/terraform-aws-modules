#==============================================================================
# FIREWALL MANAGER VARIABLES
#==============================================================================
variable "admin_account_id" {
  description = "AWS account ID to designate as FMS administrator"
  type        = string
  default     = null
}

variable "policies" {
  description = "List of Firewall Manager policies"
  type = list(object({
    name                        = string
    resource_type               = optional(string)
    resource_type_list          = optional(list(string))
    remediation_enabled         = optional(bool, false)
    delete_all_policy_resources = optional(bool, false)
    exclude_resource_tags       = optional(bool, false)
    include_account_ids         = optional(list(string), [])
    exclude_account_ids         = optional(list(string), [])
    security_service_type       = string
    managed_service_data        = optional(string)
    tags                        = optional(map(string), {})
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
