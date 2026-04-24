#==============================================================================
# STREAM VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the Kinesis stream"
  type        = string
}

variable "stream_mode" {
  description = "Stream mode (PROVISIONED or ON_DEMAND)"
  type        = string
  default     = "ON_DEMAND"
}

variable "shard_count" {
  description = "Number of shards for PROVISIONED mode"
  type        = number
  default     = 1
}

variable "retention_period" {
  description = "Data retention period in hours (24-8760)"
  type        = number
  default     = 24
}

variable "shard_level_metrics" {
  description = "List of shard-level metrics to enable"
  type        = list(string)
  default     = ["IncomingBytes", "OutgoingBytes"]
}

variable "enforce_consumer_deletion" {
  description = "Enforce consumer deletion on stream destroy"
  type        = bool
  default     = false
}

variable "encryption_type" {
  description = "Encryption type (NONE or KMS)"
  type        = string
  default     = "KMS"
}

variable "kms_key_id" {
  description = "KMS key ID (use alias/aws/kinesis for managed)"
  type        = string
  default     = "alias/aws/kinesis"
}

#==============================================================================
# CONSUMER VARIABLES
#==============================================================================
variable "consumers" {
  description = "List of stream consumers"
  type = list(object({
    name = string
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
