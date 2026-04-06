#==============================================================================
# DMS Replication Instance Variables
#==============================================================================
variable "replication_instance_id" {
  description = "The replication instance identifier"
  type        = string
}

variable "replication_instance_class" {
  description = "The compute and memory capacity of the replication instance"
  type        = string
}

variable "allocated_storage" {
  description = "The amount of storage (in GB) to be allocated for the replication instance"
  type        = number
  default     = 50
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs to associate with the replication instance"
  type        = list(string)
  default     = []
}

variable "replication_subnet_group_id" {
  description = "Existing replication subnet group identifier to use. If not provided and subnet_ids is set, a new subnet group will be created"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "List of subnet IDs for creating a new DMS replication subnet group"
  type        = list(string)
  default     = []
}

variable "multi_az" {
  description = "Whether the replication instance is a multi-az deployment"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Whether the replication instance is publicly accessible"
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Whether minor engine upgrades will be applied automatically during the maintenance window"
  type        = bool
  default     = true
}

variable "kms_key_arn" {
  description = "KMS key ARN to use for encryption at rest for the replication instance"
  type        = string
  default     = null
}

variable "engine_version" {
  description = "The engine version of the replication instance"
  type        = string
  default     = null
}

#==============================================================================
# DMS Replication Task Variables
#==============================================================================
variable "tasks" {
  description = "List of DMS replication task configurations"
  type = list(object({
    task_id                        = string
    source_endpoint_arn            = string
    target_endpoint_arn            = string
    migration_type                 = string
    table_mappings_json            = string
    replication_task_settings_json = optional(string, null)
  }))
  default = []

  validation {
    condition = alltrue([
      for t in var.tasks : contains(["full-load", "cdc", "full-load-and-cdc"], t.migration_type)
    ])
    error_message = "migration_type must be one of: full-load, cdc, full-load-and-cdc."
  }
}

#==============================================================================
# DMS Source Endpoint Variables
#==============================================================================
variable "source_endpoints" {
  description = "List of DMS source endpoint configurations"
  type = list(object({
    endpoint_id                 = string
    engine_name                 = string
    server_name                 = string
    port                        = number
    database_name               = string
    username                    = string
    password                    = string
    ssl_mode                    = optional(string, "none")
    extra_connection_attributes = optional(string, "")
    kms_key_arn                 = optional(string, null)
  }))
  default = []
}

#==============================================================================
# DMS Target Endpoint Variables
#==============================================================================
variable "target_endpoints" {
  description = "List of DMS target endpoint configurations"
  type = list(object({
    endpoint_id                 = string
    engine_name                 = string
    server_name                 = string
    port                        = number
    database_name               = string
    username                    = string
    password                    = string
    ssl_mode                    = optional(string, "none")
    extra_connection_attributes = optional(string, "")
    kms_key_arn                 = optional(string, null)
  }))
  default = []
}

#==============================================================================
# Tags
#==============================================================================
variable "tags" {
  description = "Map of tags to assign to all resources"
  type        = map(string)
  default     = {}
}
