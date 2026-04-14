#==============================================================================
# PARAMETER STORE VARIABLES
#==============================================================================
variable "parameters" {
  description = "List of SSM parameters to create"
  type = list(object({
    name            = string
    description     = optional(string, "Managed by Terraform")
    type            = optional(string, "String")
    value           = string
    kms_key_id      = optional(string)
    tier            = optional(string, "Standard")
    allowed_pattern = optional(string)
    data_type       = optional(string, "text")
    tags            = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# DOCUMENT VARIABLES
#==============================================================================
variable "documents" {
  description = "List of SSM documents to create"
  type = list(object({
    name            = string
    document_type   = optional(string, "Command")
    document_format = optional(string, "YAML")
    content         = string
    target_type     = optional(string)
    tags            = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# MAINTENANCE WINDOW VARIABLES
#==============================================================================
variable "maintenance_windows" {
  description = "List of SSM maintenance windows"
  type = list(object({
    name                       = string
    description                = optional(string, "Managed by Terraform")
    schedule                   = string
    schedule_timezone          = optional(string, "UTC")
    duration                   = number
    cutoff                     = number
    allow_unassociated_targets = optional(bool, false)
    enabled                    = optional(bool, true)
    tags                       = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# MAINTENANCE WINDOW TARGET VARIABLES
#==============================================================================
variable "maintenance_window_targets" {
  description = "List of maintenance window targets"
  type = list(object({
    name          = string
    window_name   = string
    description   = optional(string, "Managed by Terraform")
    resource_type = optional(string, "INSTANCE")
    target_key    = string
    target_values = list(string)
  }))
  default = []
}

#==============================================================================
# ASSOCIATION VARIABLES
#==============================================================================
variable "associations" {
  description = "List of SSM associations"
  type = list(object({
    name                = string
    document_name       = string
    schedule_expression = optional(string)
    parameters          = optional(map(string))
    max_concurrency     = optional(string, "50")
    max_errors          = optional(string, "0")
    compliance_severity = optional(string, "MEDIUM")
    targets = optional(list(object({
      key    = string
      values = list(string)
    })), [])
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
