#==============================================================================
# QUEUE VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the SQS queue"
  type        = string
}

variable "fifo_queue" {
  description = "Whether this is a FIFO queue"
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "Enable content-based deduplication for FIFO queues"
  type        = bool
  default     = false
}

variable "visibility_timeout_seconds" {
  description = "Visibility timeout for the queue"
  type        = number
  default     = 30
}

variable "message_retention_seconds" {
  description = "Message retention period in seconds"
  type        = number
  default     = 345600
}

variable "max_message_size" {
  description = "Maximum message size in bytes"
  type        = number
  default     = 262144
}

variable "delay_seconds" {
  description = "Delay seconds for the queue"
  type        = number
  default     = 0
}

variable "receive_wait_time_seconds" {
  description = "Wait time for long polling"
  type        = number
  default     = 0
}

#==============================================================================
# ENCRYPTION VARIABLES
#==============================================================================
variable "sqs_managed_sse_enabled" {
  description = "Enable SQS managed server-side encryption"
  type        = bool
  default     = true
}

variable "kms_master_key_id" {
  description = "KMS key ID for encryption"
  type        = string
  default     = null
}

variable "kms_data_key_reuse_period_seconds" {
  description = "KMS data key reuse period"
  type        = number
  default     = 300
}

#==============================================================================
# DEAD LETTER QUEUE VARIABLES
#==============================================================================
variable "dead_letter_queue_arn" {
  description = "ARN of an existing dead letter queue"
  type        = string
  default     = null
}

variable "max_receive_count" {
  description = "Max receive count before sending to DLQ"
  type        = number
  default     = 5
}

variable "create_dlq" {
  description = "Whether to create a dead letter queue"
  type        = bool
  default     = false
}

variable "dlq_message_retention_seconds" {
  description = "Message retention for the DLQ"
  type        = number
  default     = 1209600
}

#==============================================================================
# POLICY VARIABLES
#==============================================================================
variable "policy" {
  description = "Queue policy JSON document"
  type        = string
  default     = null
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
