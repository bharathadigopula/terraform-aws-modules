#==============================================================================
# DYNAMODB TABLE CONFIGURATION
#==============================================================================

variable "name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "billing_mode" {
  description = "Billing mode for the table. Valid values are PROVISIONED and PAY_PER_REQUEST"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "read_capacity" {
  description = "Read capacity units for the table when billing mode is PROVISIONED"
  type        = number
  default     = null
}

variable "write_capacity" {
  description = "Write capacity units for the table when billing mode is PROVISIONED"
  type        = number
  default     = null
}

variable "hash_key" {
  description = "Attribute name to use as the hash (partition) key"
  type        = string
}

variable "range_key" {
  description = "Attribute name to use as the range (sort) key"
  type        = string
  default     = null
}

#==============================================================================
# ATTRIBUTE DEFINITIONS
#==============================================================================

variable "attributes" {
  description = "List of attribute definitions for the table. Each object must contain name and type (S, N, or B)"
  type = list(object({
    name = string
    type = string
  }))
}

#==============================================================================
# GLOBAL SECONDARY INDEXES
#==============================================================================

variable "global_secondary_indexes" {
  description = "List of global secondary index definitions for the table"
  type = list(object({
    name               = string
    hash_key           = string
    range_key          = optional(string)
    projection_type    = string
    non_key_attributes = optional(list(string))
    read_capacity      = optional(number)
    write_capacity     = optional(number)
  }))
  default = []
}

#==============================================================================
# LOCAL SECONDARY INDEXES
#==============================================================================

variable "local_secondary_indexes" {
  description = "List of local secondary index definitions for the table"
  type = list(object({
    name               = string
    range_key          = string
    projection_type    = string
    non_key_attributes = optional(list(string))
  }))
  default = []
}

#==============================================================================
# TTL CONFIGURATION
#==============================================================================

variable "ttl" {
  description = "TTL configuration with attribute_name and enabled flag"
  type = object({
    attribute_name = string
    enabled        = bool
  })
  default = null
}

#==============================================================================
# BACKUP AND RECOVERY
#==============================================================================

variable "point_in_time_recovery_enabled" {
  description = "Enable point-in-time recovery for the table"
  type        = bool
  default     = true
}

#==============================================================================
# ENCRYPTION
#==============================================================================

variable "server_side_encryption" {
  description = "Server-side encryption configuration with enabled flag and optional KMS key ARN"
  type = object({
    enabled     = bool
    kms_key_arn = optional(string)
  })
  default = {
    enabled = true
  }
}

#==============================================================================
# STREAMS
#==============================================================================

variable "stream_enabled" {
  description = "Enable DynamoDB Streams on the table"
  type        = bool
  default     = false
}

variable "stream_view_type" {
  description = "Stream view type when streams are enabled. Valid values are KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES"
  type        = string
  default     = null
}

#==============================================================================
# TABLE CLASS
#==============================================================================

variable "table_class" {
  description = "Storage class for the table. Valid values are STANDARD and STANDARD_INFREQUENT_ACCESS"
  type        = string
  default     = "STANDARD"
}

#==============================================================================
# GLOBAL TABLES (REPLICA REGIONS)
#==============================================================================

variable "replica_regions" {
  description = "List of AWS regions for global table replicas"
  type        = list(string)
  default     = []
}

#==============================================================================
# TAGS
#==============================================================================

variable "tags" {
  description = "Map of tags to assign to the DynamoDB table"
  type        = map(string)
  default     = {}
}
