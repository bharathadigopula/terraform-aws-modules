#==============================================================================
# COLLABORATION VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the Clean Rooms collaboration"
  type        = string
}

variable "description" {
  description = "Description of the collaboration"
  type        = string
  default     = "Managed by Terraform"
}

variable "creator_display_name" {
  description = "Display name for the creator"
  type        = string
}

variable "creator_member_abilities" {
  description = "List of member abilities for the creator"
  type        = list(string)
  default     = ["CAN_QUERY", "CAN_RECEIVE_RESULTS"]
}

variable "query_log_status" {
  description = "Query log status (ENABLED or DISABLED)"
  type        = string
  default     = "ENABLED"
}

#==============================================================================
# ENCRYPTION VARIABLES
#==============================================================================
variable "enable_data_encryption" {
  description = "Whether to enable data encryption metadata"
  type        = bool
  default     = true
}

variable "allow_clear_text" {
  description = "Allow clear text columns"
  type        = bool
  default     = false
}

variable "allow_duplicates" {
  description = "Allow duplicate rows"
  type        = bool
  default     = false
}

variable "allow_joins_on_columns_with_different_names" {
  description = "Allow joins on columns with different names"
  type        = bool
  default     = false
}

variable "preserve_nulls" {
  description = "Preserve null values"
  type        = bool
  default     = false
}

#==============================================================================
# MEMBER VARIABLES
#==============================================================================
variable "members" {
  description = "List of collaboration members"
  type = list(object({
    account_id       = string
    display_name     = string
    member_abilities = list(string)
  }))
  default = []
}

#==============================================================================
# CONFIGURED TABLE VARIABLES
#==============================================================================
variable "configured_tables" {
  description = "List of configured tables"
  type = list(object({
    name            = string
    description     = optional(string, "Managed by Terraform")
    analysis_method = optional(string, "DIRECT_QUERY")
    allowed_columns = list(string)
    database_name   = string
    table_name      = string
    tags            = optional(map(string), {})
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
