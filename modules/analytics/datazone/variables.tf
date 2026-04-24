#==============================================================================
# DOMAIN VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the DataZone domain"
  type        = string
}

variable "description" {
  description = "Description of the domain"
  type        = string
  default     = "Managed by Terraform"
}

variable "domain_execution_role" {
  description = "IAM role ARN for domain execution"
  type        = string
}

variable "kms_key_identifier" {
  description = "KMS key identifier for encryption"
  type        = string
  default     = null
}

variable "single_sign_on_type" {
  description = "SSO type (IAM_IDC or DISABLED)"
  type        = string
  default     = null
}

variable "single_sign_on_user_assignment" {
  description = "SSO user assignment (AUTOMATIC or MANUAL)"
  type        = string
  default     = "AUTOMATIC"
}

#==============================================================================
# PROJECT VARIABLES
#==============================================================================
variable "projects" {
  description = "List of DataZone projects"
  type = list(object({
    name                = string
    description         = optional(string, "Managed by Terraform")
    glossary_terms      = optional(list(string), [])
    skip_deletion_check = optional(bool, false)
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
