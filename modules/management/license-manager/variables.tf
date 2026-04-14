#==============================================================================
# LICENSE CONFIGURATION VARIABLES
#==============================================================================
variable "license_configurations" {
  description = "List of license configurations"
  type = list(object({
    name                     = string
    description              = optional(string, "Managed by Terraform")
    license_count            = optional(number)
    license_count_hard_limit = optional(bool, false)
    license_counting_type    = string
    license_rules            = optional(list(string))
    resource_arns            = optional(list(string), [])
    tags                     = optional(map(string), {})
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
