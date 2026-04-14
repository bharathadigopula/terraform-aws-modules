#==============================================================================
# KMS KEY VARIABLES
#==============================================================================
variable "description" {
  description = "Description of the KMS key"
  type        = string
  default     = "KMS key"
}

variable "key_usage" {
  description = "Intended use of the key (ENCRYPT_DECRYPT or SIGN_VERIFY)"
  type        = string
  default     = "ENCRYPT_DECRYPT"
}

variable "customer_master_key_spec" {
  description = "Key spec (SYMMETRIC_DEFAULT, RSA_2048, etc.)"
  type        = string
  default     = "SYMMETRIC_DEFAULT"
}

variable "deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction"
  type        = number
  default     = 30
}

variable "is_enabled" {
  description = "Whether the key is enabled"
  type        = bool
  default     = true
}

variable "enable_key_rotation" {
  description = "Whether key rotation is enabled"
  type        = bool
  default     = true
}

variable "rotation_period_in_days" {
  description = "Number of days between each automatic rotation (90-2560)"
  type        = number
  default     = 365
}

variable "multi_region" {
  description = "Whether the key is a multi-Region key"
  type        = bool
  default     = false
}

variable "policy" {
  description = "Key policy JSON document"
  type        = string
  default     = null
}

#==============================================================================
# ALIAS VARIABLES
#==============================================================================
variable "aliases" {
  description = "List of alias names (without alias/ prefix)"
  type        = list(string)
  default     = []
}

#==============================================================================
# GRANT VARIABLES
#==============================================================================
variable "grants" {
  description = "List of KMS grants"
  type = list(object({
    name               = string
    grantee_principal  = string
    operations         = list(string)
    retiring_principal = optional(string)
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
