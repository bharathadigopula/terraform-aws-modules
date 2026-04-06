#==============================================================================
# FSX OPENZFS FILE SYSTEM VARIABLES
#==============================================================================

variable "storage_capacity" {
  description = "The storage capacity in GiB of the FSx OpenZFS file system"
  type        = number
}

variable "subnet_ids" {
  description = "List of subnet IDs for the file system"
  type        = list(string)
}

variable "deployment_type" {
  description = "The file system deployment type. Valid values: SINGLE_AZ_1, SINGLE_AZ_2, MULTI_AZ_1"
  type        = string
  default     = "SINGLE_AZ_1"
}

variable "throughput_capacity" {
  description = "The sustained throughput in MBps of the file system"
  type        = number
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the file system"
  type        = list(string)
  default     = []
}

variable "kms_key_id" {
  description = "ARN of the KMS key used to encrypt the file system"
  type        = string
  default     = null
}

variable "storage_type" {
  description = "The type of storage for the file system. Valid values: SSD, HDD"
  type        = string
  default     = "SSD"
}

variable "automatic_backup_retention_days" {
  description = "The number of days to retain automatic backups"
  type        = number
  default     = 7
}

variable "daily_automatic_backup_start_time" {
  description = "Daily time at which backups start, in HH:MM format (UTC)"
  type        = string
  default     = null
}

variable "weekly_maintenance_start_time" {
  description = "Weekly time at which maintenance starts, in d:HH:MM format (UTC)"
  type        = string
  default     = null
}

variable "copy_tags_to_backups" {
  description = "Whether to copy tags to backups of the file system"
  type        = bool
  default     = true
}

variable "copy_tags_to_volumes" {
  description = "Whether to copy tags to volumes of the file system"
  type        = bool
  default     = true
}

#==============================================================================
# ROOT VOLUME CONFIGURATION
#==============================================================================

variable "root_volume_configuration" {
  description = "Configuration for the root volume of the OpenZFS file system"
  type = object({
    data_compression_type = optional(string, "LZ4")
    read_only             = optional(bool)
    record_size_kib       = optional(number)
    nfs_exports = optional(object({
      client_configurations = list(object({
        clients = string
        options = list(string)
      }))
    }))
  })
  default = null
}

#==============================================================================
# DISK IOPS CONFIGURATION
#==============================================================================

variable "disk_iops_configuration" {
  description = "Disk IOPS configuration object with mode (AUTOMATIC or USER_PROVISIONED) and optional iops value"
  type = object({
    mode = optional(string, "AUTOMATIC")
    iops = optional(number)
  })
  default = null
}

#==============================================================================
# OPENZFS VOLUMES
#==============================================================================

variable "volumes" {
  description = "List of OpenZFS volume configurations to create"
  type = list(object({
    name                             = string
    parent_volume_id                 = optional(string)
    storage_capacity_quota_gib       = optional(number)
    storage_capacity_reservation_gib = optional(number)
    data_compression_type            = optional(string)
    nfs_exports = optional(object({
      client_configurations = list(object({
        clients = string
        options = list(string)
      }))
    }))
    user_and_group_quotas = optional(list(object({
      id                         = number
      storage_capacity_quota_gib = number
      type                       = string
    })))
  }))
  default = []
}

#==============================================================================
# TAGS
#==============================================================================

variable "tags" {
  description = "A map of tags to assign to all resources"
  type        = map(string)
  default     = {}
}
