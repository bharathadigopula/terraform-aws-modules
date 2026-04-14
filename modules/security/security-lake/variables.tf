#==============================================================================
# DATA LAKE VARIABLES
#==============================================================================
variable "meta_store_manager_role_arn" {
  description = "ARN of the IAM role for Security Lake meta store manager"
  type        = string
}

variable "configurations" {
  description = "List of data lake configurations per region"
  type = list(object({
    region          = string
    kms_key_id      = optional(string, "S3_MANAGED_KEY")
    expiration_days = optional(number)
    transitions = optional(list(object({
      days          = number
      storage_class = string
    })), [])
  }))
}

#==============================================================================
# LOG SOURCE VARIABLES
#==============================================================================
variable "aws_log_sources" {
  description = "List of AWS log sources to enable"
  type = list(object({
    source_name    = string
    source_version = string
    accounts       = optional(list(string))
    regions        = list(string)
  }))
  default = []
}

#==============================================================================
# SUBSCRIBER VARIABLES
#==============================================================================
variable "subscribers" {
  description = "List of Security Lake subscribers"
  type = list(object({
    subscriber_name        = string
    subscriber_description = optional(string, "")
    access_type            = optional(string, "S3")
    external_id            = string
    principal              = string
    sources = list(object({
      source_name    = string
      source_version = string
    }))
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
