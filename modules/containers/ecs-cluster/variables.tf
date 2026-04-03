#==============================================================================
# ECS CLUSTER VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "container_insights" {
  description = "Value for CloudWatch Container Insights - enabled or disabled"
  type        = string
  default     = "enabled"

  validation {
    condition     = contains(["enabled", "disabled"], var.container_insights)
    error_message = "container_insights must be either enabled or disabled."
  }
}

variable "capacity_providers" {
  description = "List of capacity providers to associate with the cluster (e.g. FARGATE, FARGATE_SPOT)"
  type        = list(string)
  default     = []
}

variable "default_capacity_provider_strategy" {
  description = "List of default capacity provider strategies for the cluster"
  type = list(object({
    capacity_provider = string
    weight            = optional(number, 0)
    base              = optional(number, 0)
  }))
  default = []
}

variable "execute_command_configuration" {
  description = "Configuration for ECS Exec including KMS key and logging settings"
  type = object({
    kms_key_id = optional(string, null)
    logging    = optional(string, "DEFAULT")
    log_configuration = optional(object({
      cloud_watch_encryption_enabled = optional(bool, false)
      cloud_watch_log_group_name     = optional(string, null)
      s3_bucket_name                 = optional(string, null)
      s3_bucket_encryption_enabled   = optional(bool, false)
      s3_key_prefix                  = optional(string, null)
    }), null)
  })
  default = null
}

variable "service_connect_defaults" {
  description = "Service Connect default namespace configuration"
  type = object({
    namespace = string
  })
  default = null
}

variable "tags" {
  description = "Map of tags to assign to all resources"
  type        = map(string)
  default     = {}
}
