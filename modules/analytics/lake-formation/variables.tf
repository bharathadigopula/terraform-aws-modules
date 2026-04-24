#==============================================================================
# DATA LAKE SETTINGS VARIABLES
#==============================================================================
variable "admins" {
  description = "List of administrator IAM ARNs"
  type        = list(string)
  default     = []
}

variable "read_only_admins" {
  description = "List of read-only admin ARNs"
  type        = list(string)
  default     = []
}

variable "trusted_resource_owners" {
  description = "List of trusted AWS account IDs"
  type        = list(string)
  default     = []
}

variable "allow_external_data_filtering" {
  description = "Allow external data filtering"
  type        = bool
  default     = false
}

variable "allow_full_table_external_data_access" {
  description = "Allow full table external data access"
  type        = bool
  default     = false
}

variable "external_data_filtering_allow_list" {
  description = "List of external AWS account IDs allowed for filtering"
  type        = list(string)
  default     = []
}

variable "create_database_default_permissions" {
  description = "Default permissions for database creation"
  type = list(object({
    permissions = list(string)
    principal   = string
  }))
  default = []
}

variable "create_table_default_permissions" {
  description = "Default permissions for table creation"
  type = list(object({
    permissions = list(string)
    principal   = string
  }))
  default = []
}

#==============================================================================
# RESOURCE VARIABLES
#==============================================================================
variable "resources" {
  description = "List of S3 locations to register with Lake Formation"
  type = list(object({
    arn                     = string
    role_arn                = optional(string)
    use_service_linked_role = optional(bool, true)
    hybrid_access_enabled   = optional(bool, false)
  }))
  default = []
}

#==============================================================================
# PERMISSION VARIABLES
#==============================================================================
variable "permissions" {
  description = "List of Lake Formation permissions"
  type = list(object({
    principal                     = string
    permissions                   = list(string)
    permissions_with_grant_option = optional(list(string), [])
    catalog_id                    = optional(string)
    catalog_resource              = optional(bool, false)
    database_name                 = optional(string)
    table_name                    = optional(string)
    data_location_arn             = optional(string)
  }))
  default = []
}
