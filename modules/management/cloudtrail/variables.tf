#==============================================================================
# CLOUDTRAIL VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the CloudTrail trail"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket for CloudTrail logs"
  type        = string
}

variable "s3_key_prefix" {
  description = "S3 key prefix for CloudTrail logs"
  type        = string
  default     = null
}

variable "cloud_watch_logs_group_arn" {
  description = "CloudWatch Logs group ARN for trail logs"
  type        = string
  default     = null
}

variable "cloud_watch_logs_role_arn" {
  description = "IAM role ARN for CloudWatch Logs delivery"
  type        = string
  default     = null
}

variable "sns_topic_name" {
  description = "SNS topic name for trail notifications"
  type        = string
  default     = null
}

variable "kms_key_id" {
  description = "KMS key ARN for encrypting CloudTrail logs"
  type        = string
  default     = null
}

variable "is_multi_region_trail" {
  description = "Whether the trail is multi-region"
  type        = bool
  default     = true
}

variable "is_organization_trail" {
  description = "Whether the trail is an organization trail"
  type        = bool
  default     = false
}

variable "include_global_service_events" {
  description = "Whether to include global service events"
  type        = bool
  default     = true
}

variable "enable_log_file_validation" {
  description = "Whether to enable log file integrity validation"
  type        = bool
  default     = true
}

variable "enable_logging" {
  description = "Whether logging is enabled"
  type        = bool
  default     = true
}

#==============================================================================
# EVENT SELECTOR VARIABLES
#==============================================================================
variable "event_selectors" {
  description = "List of event selectors"
  type = list(object({
    read_write_type           = optional(string, "All")
    include_management_events = optional(bool, true)
    data_resources = optional(list(object({
      type   = string
      values = list(string)
    })), [])
  }))
  default = []
}

variable "advanced_event_selectors" {
  description = "List of advanced event selectors"
  type = list(object({
    name = string
    field_selectors = list(object({
      field           = string
      equals          = optional(list(string))
      not_equals      = optional(list(string))
      starts_with     = optional(list(string))
      not_starts_with = optional(list(string))
      ends_with       = optional(list(string))
      not_ends_with   = optional(list(string))
    }))
  }))
  default = []
}

variable "insight_selectors" {
  description = "List of insight types (ApiCallRateInsight, ApiErrorRateInsight)"
  type        = list(string)
  default     = []
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
