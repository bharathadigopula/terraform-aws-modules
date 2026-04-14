#==============================================================================
# RECORDER VARIABLES
#==============================================================================
variable "create_recorder" {
  description = "Whether to create a Config recorder and delivery channel"
  type        = bool
  default     = true
}

variable "recorder_name" {
  description = "Name of the Config recorder"
  type        = string
  default     = "default"
}

variable "recorder_role_arn" {
  description = "IAM role ARN for the Config recorder"
  type        = string
  default     = null
}

variable "recorder_enabled" {
  description = "Whether the Config recorder is enabled"
  type        = bool
  default     = true
}

variable "recording_all_supported" {
  description = "Whether to record all supported resource types"
  type        = bool
  default     = true
}

variable "include_global_resource_types" {
  description = "Whether to include global resource types"
  type        = bool
  default     = true
}

variable "recording_resource_types" {
  description = "List of specific resource types to record"
  type        = list(string)
  default     = []
}

variable "recording_frequency" {
  description = "Recording frequency (CONTINUOUS or DAILY)"
  type        = string
  default     = "CONTINUOUS"
}

#==============================================================================
# DELIVERY CHANNEL VARIABLES
#==============================================================================
variable "delivery_channel_name" {
  description = "Name of the delivery channel"
  type        = string
  default     = "default"
}

variable "delivery_s3_bucket" {
  description = "S3 bucket for Config delivery"
  type        = string
  default     = null
}

variable "delivery_s3_key_prefix" {
  description = "S3 key prefix for Config delivery"
  type        = string
  default     = null
}

variable "delivery_sns_topic_arn" {
  description = "SNS topic ARN for Config notifications"
  type        = string
  default     = null
}

variable "delivery_frequency" {
  description = "Frequency of Config snapshot delivery"
  type        = string
  default     = "TwentyFour_Hours"
}

#==============================================================================
# MANAGED RULE VARIABLES
#==============================================================================
variable "managed_rules" {
  description = "List of AWS managed Config rules"
  type = list(object({
    name                        = string
    description                 = optional(string, "Managed by Terraform")
    source_identifier           = string
    input_parameters            = optional(string)
    maximum_execution_frequency = optional(string)
    resource_types              = optional(list(string))
    tags                        = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# CUSTOM RULE VARIABLES
#==============================================================================
variable "custom_rules" {
  description = "List of custom Lambda-based Config rules"
  type = list(object({
    name                        = string
    description                 = optional(string, "Managed by Terraform")
    lambda_function_arn         = string
    input_parameters            = optional(string)
    maximum_execution_frequency = optional(string)
    resource_types              = optional(list(string))
    source_details = optional(list(object({
      event_source = optional(string, "aws.config")
      message_type = string
    })), [])
    tags = optional(map(string), {})
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
