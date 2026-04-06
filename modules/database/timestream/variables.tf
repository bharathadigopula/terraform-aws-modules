#==============================================================================
# TIMESTREAM DATABASE VARIABLES
#==============================================================================

variable "database_name" {
  description = "The name of the Timestream database"
  type        = string
}

variable "kms_key_id" {
  description = "The ARN of the KMS key used to encrypt the Timestream database"
  type        = string
  default     = null
}

variable "tables" {
  description = "List of Timestream table configurations including retention and magnetic store write properties"
  type = list(object({
    table_name = string
    retention_properties = optional(object({
      memory_store_retention_period_in_hours  = optional(number, 24)
      magnetic_store_retention_period_in_days = optional(number, 365)
    }))
    magnetic_store_write_properties = optional(object({
      enable_magnetic_store_writes = optional(bool, true)
    }))
  }))
  default = []
}

variable "tags" {
  description = "A map of tags to assign to the Timestream resources"
  type        = map(string)
  default     = {}
}
