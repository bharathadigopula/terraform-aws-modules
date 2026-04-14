#==============================================================================
# PORTFOLIO VARIABLES
#==============================================================================
variable "portfolios" {
  description = "List of Service Catalog portfolios"
  type = list(object({
    name           = string
    description    = optional(string, "Managed by Terraform")
    provider_name  = string
    principal_arns = optional(list(string), [])
    tags           = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# PRODUCT VARIABLES
#==============================================================================
variable "products" {
  description = "List of Service Catalog products"
  type = list(object({
    name                        = string
    owner                       = string
    description                 = optional(string, "Managed by Terraform")
    type                        = optional(string, "CLOUD_FORMATION_TEMPLATE")
    distributor                 = optional(string)
    artifact_name               = optional(string, "v1")
    artifact_description        = optional(string, "Initial version")
    artifact_type               = optional(string, "CLOUD_FORMATION_TEMPLATE")
    template_url                = string
    disable_template_validation = optional(bool, false)
    portfolio_names             = optional(list(string), [])
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
