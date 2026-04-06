#==============================================================================
# FSX LUSTRE FILE SYSTEM VARIABLES
#==============================================================================
variable "storage_capacity" {
  description = "Storage capacity of the file system in GiB"
  type        = number
}

variable "subnet_ids" {
  description = "List of subnet IDs for the file system (Lustre requires exactly 1 subnet)"
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) == 1
    error_message = "Lustre file systems require exactly one subnet ID."
  }
}

variable "deployment_type" {
  description = "Lustre deployment type (SCRATCH_1, SCRATCH_2, PERSISTENT_1, PERSISTENT_2)"
  type        = string
  default     = "PERSISTENT_2"
}

variable "per_unit_storage_throughput" {
  description = "Per unit storage throughput in MB/s/TiB for PERSISTENT deployment types"
  type        = number
  default     = null
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

variable "import_path" {
  description = "S3 URI for importing data to the file system"
  type        = string
  default     = null
}

variable "export_path" {
  description = "S3 URI for exporting data from the file system"
  type        = string
  default     = null
}

variable "imported_file_chunk_size" {
  description = "Chunk size in MiB for files imported from S3"
  type        = number
  default     = null
}

variable "auto_import_policy" {
  description = "How Amazon FSx keeps your file and directory listings up to date as you add or modify objects in your linked S3 bucket"
  type        = string
  default     = null
}

variable "data_compression_type" {
  description = "Data compression type for the file system (NONE or LZ4)"
  type        = string
  default     = "LZ4"
}

variable "storage_type" {
  description = "Storage type for the file system (SSD or HDD)"
  type        = string
  default     = "SSD"
}

variable "weekly_maintenance_start_time" {
  description = "Weekly recurring maintenance start time in d:HH:MM format"
  type        = string
  default     = null
}

variable "automatic_backup_retention_days" {
  description = "Number of days to retain automatic backups (0 to disable)"
  type        = number
  default     = 7
}

variable "daily_automatic_backup_start_time" {
  description = "Daily time to begin automatic backups in HH:MM format"
  type        = string
  default     = null
}

variable "copy_tags_to_backups" {
  description = "Whether to copy tags to backups"
  type        = bool
  default     = true
}

variable "drive_cache_type" {
  description = "Type of drive cache used by PERSISTENT_1 deployment types (NONE or READ)"
  type        = string
  default     = null
}

variable "file_system_type_version" {
  description = "Lustre file system version (2.10 or 2.12)"
  type        = string
  default     = null
}

variable "log_configuration" {
  description = "Lustre logging configuration with log level and CloudWatch destination"
  type = object({
    level       = optional(string, "WARN_ERROR")
    destination = optional(string)
  })
  default = null
}

variable "tags" {
  description = "Map of tags to assign to the file system"
  type        = map(string)
  default     = {}
}
