#==============================================================================
# EFS FILE SYSTEM VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the EFS file system"
  type        = string
}

variable "encrypted" {
  description = "Whether to enable encryption at rest for the file system"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "ARN of the KMS key used to encrypt the file system"
  type        = string
  default     = null
}

variable "performance_mode" {
  description = "Performance mode of the file system (generalPurpose or maxIO)"
  type        = string
  default     = "generalPurpose"
}

variable "throughput_mode" {
  description = "Throughput mode for the file system (bursting, provisioned, or elastic)"
  type        = string
  default     = "bursting"
}

variable "provisioned_throughput_in_mibps" {
  description = "Throughput in MiB/s when throughput_mode is set to provisioned"
  type        = number
  default     = null
}

variable "lifecycle_policy" {
  description = "List of lifecycle policy objects with transition rules"
  type = list(object({
    transition_to_ia                    = optional(string)
    transition_to_primary_storage_class = optional(string)
  }))
  default = []
}

#==============================================================================
# MOUNT TARGET VARIABLES
#==============================================================================
variable "subnet_ids" {
  description = "List of subnet IDs where mount targets will be created"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with mount targets"
  type        = list(string)
}

#==============================================================================
# ACCESS POINT VARIABLES
#==============================================================================
variable "access_points" {
  description = "List of access point configurations for the EFS file system"
  type = list(object({
    name                = string
    root_directory_path = optional(string)
    root_directory_creation_info = optional(object({
      owner_gid   = number
      owner_uid   = number
      permissions = string
    }))
    posix_user = optional(object({
      gid            = number
      uid            = number
      secondary_gids = optional(list(number))
    }))
  }))
  default = []
}

#==============================================================================
# FILE SYSTEM POLICY VARIABLES
#==============================================================================
variable "file_system_policy" {
  description = "JSON string of the file system resource policy"
  type        = string
  default     = null
}

#==============================================================================
# BACKUP POLICY VARIABLES
#==============================================================================
variable "backup_policy_status" {
  description = "Status of the backup policy (ENABLED or DISABLED)"
  type        = string
  default     = "ENABLED"
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================
variable "tags" {
  description = "Map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}
