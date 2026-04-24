#==============================================================================
# WORKGROUP VARIABLES
#==============================================================================
variable "workgroup_name" {
  description = "Name of the Athena workgroup"
  type        = string
}

variable "description" {
  description = "Description of the workgroup"
  type        = string
  default     = "Managed by Terraform"
}

variable "state" {
  description = "State of the workgroup (ENABLED or DISABLED)"
  type        = string
  default     = "ENABLED"
}

variable "force_destroy" {
  description = "Force destroy workgroup even with history"
  type        = bool
  default     = false
}

variable "enforce_workgroup_configuration" {
  description = "Whether to enforce workgroup config over client settings"
  type        = bool
  default     = true
}

variable "publish_cloudwatch_metrics_enabled" {
  description = "Whether to publish CloudWatch metrics"
  type        = bool
  default     = true
}

variable "bytes_scanned_cutoff_per_query" {
  description = "Max bytes scanned per query (min 10485760)"
  type        = number
  default     = null
}

variable "requester_pays_enabled" {
  description = "Whether requester pays for S3"
  type        = bool
  default     = false
}

variable "output_location" {
  description = "S3 location for query results (s3://bucket/prefix/)"
  type        = string
}

variable "encryption_option" {
  description = "Encryption option (SSE_S3, SSE_KMS, CSE_KMS)"
  type        = string
  default     = "SSE_S3"
}

variable "kms_key_arn" {
  description = "KMS key ARN for SSE_KMS or CSE_KMS"
  type        = string
  default     = null
}

#==============================================================================
# DATABASE VARIABLES
#==============================================================================
variable "databases" {
  description = "List of Athena databases"
  type = list(object({
    name              = string
    bucket            = string
    force_destroy     = optional(bool, false)
    comment           = optional(string, "Managed by Terraform")
    encryption_option = optional(string)
    kms_key           = optional(string)
  }))
  default = []
}

#==============================================================================
# NAMED QUERY VARIABLES
#==============================================================================
variable "named_queries" {
  description = "List of Athena named queries"
  type = list(object({
    name        = string
    database    = string
    query       = string
    description = optional(string, "Managed by Terraform")
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
