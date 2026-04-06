#==============================================================================
# S3 REPLICATION CONFIGURATION VARIABLES
#==============================================================================
variable "source_bucket_id" {
  description = "ID of the source S3 bucket for replication"
  type        = string
}

variable "role_arn" {
  description = "ARN of the IAM role for S3 to assume when replicating objects"
  type        = string
}

variable "rules" {
  description = "List of replication rule configurations"
  type = list(object({
    id       = string
    status   = optional(string, "Enabled")
    priority = optional(number)
    filter = optional(object({
      prefix = optional(string)
      tags   = optional(map(string))
    }))
    destination = object({
      bucket_arn          = string
      storage_class       = optional(string)
      account_id          = optional(string)
      replica_kms_key_id  = optional(string)
    })
    delete_marker_replication     = optional(string, "Enabled")
    existing_object_replication   = optional(string, "Enabled")
  }))
}

