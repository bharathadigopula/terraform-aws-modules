#==============================================================================
# ECR REPOSITORY VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "image_tag_mutability" {
  description = "Tag mutability setting for the repository. Valid values are MUTABLE or IMMUTABLE"
  type        = string
  default     = "IMMUTABLE"

  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "image_tag_mutability must be either MUTABLE or IMMUTABLE."
  }
}

variable "scan_on_push" {
  description = "Enable image scanning on push"
  type        = bool
  default     = true
}

variable "encryption_type" {
  description = "Encryption type for the repository. Valid values are AES256 or KMS"
  type        = string
  default     = "AES256"

  validation {
    condition     = contains(["AES256", "KMS"], var.encryption_type)
    error_message = "encryption_type must be either AES256 or KMS."
  }
}

variable "kms_key" {
  description = "ARN of the KMS key used for encryption. Required when encryption_type is KMS"
  type        = string
  default     = null
}

variable "force_delete" {
  description = "Delete the repository even if it contains images"
  type        = bool
  default     = false
}

#==============================================================================
# POLICY VARIABLES
#==============================================================================
variable "lifecycle_policy" {
  description = "JSON string defining the ECR lifecycle policy"
  type        = string
  default     = null
}

variable "repository_policy" {
  description = "JSON string defining the ECR repository access policy"
  type        = string
  default     = null
}

#==============================================================================
# TAGS
#==============================================================================
variable "tags" {
  description = "Map of tags to assign to the repository"
  type        = map(string)
  default     = {}
}
