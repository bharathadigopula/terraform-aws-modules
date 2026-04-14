#==============================================================================
# SECRET VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the secret"
  type        = string
}

variable "description" {
  description = "Description of the secret"
  type        = string
  default     = ""
}

variable "kms_key_id" {
  description = "KMS key ID for encrypting the secret"
  type        = string
  default     = null
}

variable "recovery_window_in_days" {
  description = "Number of days before permanent deletion (0 for immediate)"
  type        = number
  default     = 30
}

variable "force_overwrite_replica_secret" {
  description = "Whether to overwrite a secret with the same name in the destination region"
  type        = bool
  default     = false
}

variable "secret_string" {
  description = "Secret value as a string"
  type        = string
  default     = null
  sensitive   = true
}

variable "secret_binary" {
  description = "Secret value as binary (base64 encoded)"
  type        = string
  default     = null
  sensitive   = true
}

#==============================================================================
# REPLICA VARIABLES
#==============================================================================
variable "replica_regions" {
  description = "List of regions to replicate the secret to"
  type = list(object({
    region     = string
    kms_key_id = optional(string)
  }))
  default = []
}

#==============================================================================
# ROTATION VARIABLES
#==============================================================================
variable "rotation_lambda_arn" {
  description = "ARN of the Lambda function that can rotate the secret"
  type        = string
  default     = null
}

variable "rotation_rules" {
  description = "Rotation rules configuration"
  type = object({
    automatically_after_days = optional(number)
    duration                 = optional(string)
    schedule_expression      = optional(string)
  })
  default = {
    automatically_after_days = 30
  }
}

#==============================================================================
# POLICY VARIABLES
#==============================================================================
variable "policy" {
  description = "Resource policy JSON document"
  type        = string
  default     = null
}

variable "block_public_policy" {
  description = "Whether to block public access to the secret"
  type        = bool
  default     = true
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
