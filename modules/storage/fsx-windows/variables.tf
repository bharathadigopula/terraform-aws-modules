#==============================================================================
# FSX WINDOWS FILE SYSTEM VARIABLES
#==============================================================================
variable "storage_capacity" {
  description = "Storage capacity of the file system in GiB"
  type        = number
}

variable "subnet_ids" {
  description = "List of subnet IDs for the file system (1 for SINGLE_AZ, 2 for MULTI_AZ)"
  type        = list(string)
}

variable "deployment_type" {
  description = "File system deployment type (MULTI_AZ_1, SINGLE_AZ_1, SINGLE_AZ_2)"
  type        = string
  default     = "SINGLE_AZ_1"
}

variable "throughput_capacity" {
  description = "Throughput capacity in MB/s for the file system"
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

variable "active_directory_id" {
  description = "ID of the AWS Managed Microsoft AD directory to join"
  type        = string
  default     = null
}

variable "self_managed_active_directory" {
  description = "Configuration for a self-managed Microsoft Active Directory"
  type = object({
    dns_ips                                = list(string)
    domain_name                            = string
    password                               = string
    username                               = string
    file_system_administrators_group       = optional(string)
    organizational_unit_distinguished_name = optional(string)
  })
  default = null
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

variable "aliases" {
  description = "List of DNS alias names to associate with the file system"
  type        = list(string)
  default     = []
}

variable "audit_log_configuration" {
  description = "Audit log configuration for the file system with destination and access log levels"
  type = object({
    audit_log_destination             = optional(string)
    file_access_audit_log_level       = optional(string, "SUCCESS_AND_FAILURE")
    file_share_access_audit_log_level = optional(string, "SUCCESS_AND_FAILURE")
  })
  default = null
}

variable "tags" {
  description = "Map of tags to assign to the file system"
  type        = map(string)
  default     = {}
}
