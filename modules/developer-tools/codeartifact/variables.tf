#==============================================================================
# CODEARTIFACT DOMAIN VARIABLES
#==============================================================================

variable "domains" {
  description = "List of CodeArtifact domains to create"
  type = list(object({
    name           = string
    encryption_key = optional(string)
    tags           = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# CODEARTIFACT REPOSITORY VARIABLES
#==============================================================================

variable "repositories" {
  description = "List of CodeArtifact repositories to create"
  type = list(object({
    name                     = string
    domain                   = string
    domain_owner             = optional(string)
    description              = optional(string)
    external_connection_name = optional(string)
    upstream_repositories    = optional(list(string), [])
    tags                     = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================

variable "tags" {
  description = "Tags to apply to all supported resources"
  type        = map(string)
  default     = {}
}
