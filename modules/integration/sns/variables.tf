#==============================================================================
# TOPIC VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the SNS topic"
  type        = string
}

variable "display_name" {
  description = "Display name for the topic"
  type        = string
  default     = null
}

variable "fifo_topic" {
  description = "Whether this is a FIFO topic"
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "Enable content-based deduplication for FIFO topics"
  type        = bool
  default     = false
}

variable "kms_master_key_id" {
  description = "KMS key ID for encryption"
  type        = string
  default     = null
}

variable "policy" {
  description = "Topic policy JSON document"
  type        = string
  default     = null
}

variable "delivery_policy" {
  description = "SNS delivery policy JSON"
  type        = string
  default     = null
}

variable "tracing_config" {
  description = "Tracing mode (PassThrough or Active)"
  type        = string
  default     = null
}

variable "signature_version" {
  description = "Signature version for SNS notifications (1 or 2)"
  type        = string
  default     = null
}

#==============================================================================
# SUBSCRIPTION VARIABLES
#==============================================================================
variable "subscriptions" {
  description = "List of SNS subscriptions"
  type = list(object({
    protocol             = string
    endpoint             = string
    filter_policy        = optional(string)
    filter_policy_scope  = optional(string, "MessageAttributes")
    raw_message_delivery = optional(bool, false)
    redrive_policy       = optional(string)
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
