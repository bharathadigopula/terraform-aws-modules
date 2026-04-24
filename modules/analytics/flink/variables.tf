#==============================================================================
# APPLICATION VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the Flink application"
  type        = string
}

variable "description" {
  description = "Description of the application"
  type        = string
  default     = "Managed by Terraform"
}

variable "runtime_environment" {
  description = "Runtime environment (FLINK-1_15, FLINK-1_18, etc.)"
  type        = string
  default     = "FLINK-1_18"
}

variable "service_execution_role" {
  description = "IAM role ARN for application execution"
  type        = string
}

variable "start_application" {
  description = "Whether to start the application after creation"
  type        = bool
  default     = true
}

#==============================================================================
# CODE CONTENT VARIABLES
#==============================================================================
variable "code_content_type" {
  description = "Code content type (PLAINTEXT or ZIPFILE)"
  type        = string
  default     = "ZIPFILE"
}

variable "code_content" {
  description = "Code content configuration"
  type = object({
    s3_bucket_arn     = optional(string)
    s3_file_key       = optional(string)
    s3_object_version = optional(string)
    text_content      = optional(string)
  })
  default = null
}

#==============================================================================
# FLINK CONFIG VARIABLES
#==============================================================================
variable "flink_config" {
  description = "Flink application configuration"
  type = object({
    checkpoint_enabled            = optional(bool, true)
    checkpoint_interval           = optional(number, 60000)
    min_pause_between_checkpoints = optional(number, 5000)
    log_level                     = optional(string, "INFO")
    metrics_level                 = optional(string, "APPLICATION")
    parallelism                   = optional(number, 1)
    parallelism_per_kpu           = optional(number, 1)
    auto_scaling_enabled          = optional(bool, true)
  })
  default = null
}

#==============================================================================
# PROPERTY GROUP VARIABLES
#==============================================================================
variable "property_groups" {
  description = "List of environment property groups"
  type = list(object({
    id         = string
    properties = map(string)
  }))
  default = []
}

#==============================================================================
# LOGGING VARIABLES
#==============================================================================
variable "cloudwatch_log_stream_arn" {
  description = "CloudWatch Log Stream ARN for application logs"
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
