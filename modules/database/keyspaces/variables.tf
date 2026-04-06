#==============================================================================
# KEYSPACE VARIABLES
#==============================================================================

variable "keyspace_name" {
  description = "Name of the Amazon Keyspaces keyspace"
  type        = string
}

#==============================================================================
# TABLE VARIABLES
#==============================================================================

variable "tables" {
  description = "List of tables to create within the keyspace"
  type = list(object({
    table_name = string
    schema_definition = object({
      all_columns = list(object({
        name = string
        type = string
      }))
      partition_key = list(string)
      clustering_key = optional(list(object({
        name     = string
        order_by = string
      })), [])
      static_columns = optional(list(string), [])
    })
    point_in_time_recovery = optional(bool, true)
    throughput_mode        = optional(string, "PAY_PER_REQUEST")
    read_capacity_units    = optional(number, null)
    write_capacity_units   = optional(number, null)
    default_time_to_live   = optional(number, null)
    encryption_type        = optional(string, "AWS_OWNED_KMS_KEY")
    kms_key_identifier     = optional(string, null)
  }))
  default = []
}

#==============================================================================
# TAGS
#==============================================================================

variable "tags" {
  description = "Map of tags to assign to all resources"
  type        = map(string)
  default     = {}
}
