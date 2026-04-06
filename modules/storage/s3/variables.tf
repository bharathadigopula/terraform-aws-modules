#==============================================================================
# S3 BUCKET VARIABLES
#==============================================================================
variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "force_destroy" {
  description = "Allow destruction of a non-empty bucket"
  type        = bool
  default     = false
}

variable "object_lock_enabled" {
  description = "Enable S3 object lock on the bucket"
  type        = bool
  default     = false
}

variable "versioning_enabled" {
  description = "Enable versioning on the bucket"
  type        = bool
  default     = true
}

variable "server_side_encryption" {
  description = "Server-side encryption configuration for the bucket"
  type = object({
    sse_algorithm      = optional(string, "aws:kms")
    kms_master_key_id  = optional(string, null)
    bucket_key_enabled = optional(bool, true)
  })
  default = {}
}

variable "block_public_access" {
  description = "S3 bucket public access block configuration"
  type = object({
    block_public_acls       = optional(bool, true)
    block_public_policy     = optional(bool, true)
    ignore_public_acls      = optional(bool, true)
    restrict_public_buckets = optional(bool, true)
  })
  default = {}
}

variable "lifecycle_rules" {
  description = "List of lifecycle rule configurations for the bucket"
  type = list(object({
    id                                 = string
    enabled                            = bool
    prefix                             = optional(string, null)
    expiration_days                    = optional(number, null)
    noncurrent_version_expiration_days = optional(number, null)
    transition = optional(object({
      days          = number
      storage_class = string
    }), null)
    noncurrent_version_transition = optional(object({
      days          = number
      storage_class = string
    }), null)
  }))
  default = []
}

variable "cors_rules" {
  description = "List of CORS rule configurations for the bucket"
  type = list(object({
    allowed_headers = optional(list(string), [])
    allowed_methods = list(string)
    allowed_origins = list(string)
    expose_headers  = optional(list(string), [])
    max_age_seconds = optional(number, 0)
  }))
  default = []
}

variable "logging" {
  description = "Access logging configuration for the bucket"
  type = object({
    target_bucket = string
    target_prefix = optional(string, "")
  })
  default = null
}

variable "policy" {
  description = "JSON string of the IAM policy to attach to the bucket"
  type        = string
  default     = null
}

variable "tags" {
  description = "Map of tags to assign to the bucket"
  type        = map(string)
  default     = {}
}
