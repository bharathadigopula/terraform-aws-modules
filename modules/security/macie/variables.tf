#==============================================================================
# MACIE ACCOUNT VARIABLES
#==============================================================================
variable "finding_publishing_frequency" {
  description = "Frequency of publishing findings (FIFTEEN_MINUTES, ONE_HOUR, SIX_HOURS)"
  type        = string
  default     = "SIX_HOURS"
}

variable "status" {
  description = "Status of the Macie account (ENABLED or PAUSED)"
  type        = string
  default     = "ENABLED"
}

#==============================================================================
# EXPORT CONFIGURATION VARIABLES
#==============================================================================
variable "export_s3_destination" {
  description = "S3 destination for classification export"
  type = object({
    bucket_name = string
    key_prefix  = optional(string)
    kms_key_arn = string
  })
  default = null
}

#==============================================================================
# CLASSIFICATION JOB VARIABLES
#==============================================================================
variable "classification_jobs" {
  description = "List of classification jobs to create"
  type = list(object({
    name                = string
    job_type            = string
    job_status          = optional(string, "RUNNING")
    sampling_percentage = optional(number, 100)
    bucket_definitions = list(object({
      account_id = string
      buckets    = list(string)
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
