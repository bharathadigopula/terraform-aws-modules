#==============================================================================
# FLOW VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the AppFlow flow"
  type        = string
}

variable "description" {
  description = "Description of the flow"
  type        = string
  default     = "Managed by Terraform"
}

variable "kms_arn" {
  description = "KMS key ARN for encryption"
  type        = string
  default     = null
}

#==============================================================================
# SOURCE VARIABLES
#==============================================================================
variable "source_connector_type" {
  description = "Source connector type (S3, Salesforce, etc.)"
  type        = string
}

variable "source_connector_profile_name" {
  description = "Source connector profile name"
  type        = string
  default     = null
}

variable "source_s3_config" {
  description = "S3 source configuration"
  type = object({
    bucket_name   = string
    bucket_prefix = optional(string)
  })
  default = null
}

variable "source_salesforce_config" {
  description = "Salesforce source configuration"
  type = object({
    object                      = string
    enable_dynamic_field_update = optional(bool, false)
    include_deleted_records     = optional(bool, false)
  })
  default = null
}

#==============================================================================
# DESTINATION VARIABLES
#==============================================================================
variable "destination_connector_type" {
  description = "Destination connector type (S3, Redshift, etc.)"
  type        = string
}

variable "destination_connector_profile_name" {
  description = "Destination connector profile name"
  type        = string
  default     = null
}

variable "destination_s3_config" {
  description = "S3 destination configuration"
  type = object({
    bucket_name                 = string
    bucket_prefix               = optional(string)
    file_type                   = optional(string, "JSON")
    preserve_source_data_typing = optional(bool, false)
    aggregation_type            = optional(string, "None")
  })
  default = null
}

#==============================================================================
# TASK VARIABLES
#==============================================================================
variable "tasks" {
  description = "List of flow tasks"
  type = list(object({
    task_type     = string
    source_fields = list(string)
    connector_operator = optional(object({
      s3         = optional(string)
      salesforce = optional(string)
    }))
    destination_field = optional(string)
    task_properties   = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# TRIGGER VARIABLES
#==============================================================================
variable "trigger_type" {
  description = "Trigger type (OnDemand, Scheduled, Event)"
  type        = string
  default     = "OnDemand"
}

variable "schedule_config" {
  description = "Schedule configuration for Scheduled trigger type"
  type = object({
    schedule_expression = string
    data_pull_mode      = optional(string, "Incremental")
    schedule_start_time = optional(string)
    schedule_end_time   = optional(string)
    timezone            = optional(string, "UTC")
  })
  default = null
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
