#==============================================================================
# DATASYNC LOCATION VARIABLES
#==============================================================================

variable "s3_locations" {
  description = "List of DataSync S3 locations to create"
  type = list(object({
    name                   = string
    s3_bucket_arn          = string
    bucket_access_role_arn = string
    subdirectory           = string
    s3_storage_class       = optional(string)
    agent_arns             = optional(set(string))
    tags                   = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# DATASYNC TASK VARIABLES
#==============================================================================

variable "tasks" {
  description = "List of DataSync tasks to create"
  type = list(object({
    name                      = string
    source_location_name      = optional(string)
    source_location_arn       = optional(string)
    destination_location_name = optional(string)
    destination_location_arn  = optional(string)
    cloudwatch_log_group_arn  = optional(string)
    task_mode                 = optional(string)
    includes = optional(object({
      filter_type = optional(string)
      value       = optional(string)
    }))
    excludes = optional(object({
      filter_type = optional(string)
      value       = optional(string)
    }))
    schedule = optional(object({
      schedule_expression = string
      status              = optional(string)
    }))
    options = optional(object({
      atime                  = optional(string)
      bytes_per_second       = optional(number)
      gid                    = optional(string)
      log_level              = optional(string)
      mtime                  = optional(string)
      object_tags            = optional(string)
      overwrite_mode         = optional(string)
      posix_permissions      = optional(string)
      preserve_deleted_files = optional(string)
      preserve_devices       = optional(string)
      task_queueing          = optional(string)
      transfer_mode          = optional(string)
      uid                    = optional(string)
      verify_mode            = optional(string)
    }))
    tags = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================

variable "tags" {
  description = "Tags to apply to all supported resources"
  type        = map(string)
  default     = {}
}
