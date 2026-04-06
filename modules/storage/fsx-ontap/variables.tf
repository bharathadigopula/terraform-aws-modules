#==============================================================================
# FSX ONTAP FILE SYSTEM VARIABLES
#==============================================================================

variable "storage_capacity" {
  description = "The storage capacity in GiB of the FSx ONTAP file system"
  type        = number
}

variable "subnet_ids" {
  description = "List of subnet IDs for the file system"
  type        = list(string)
}

variable "deployment_type" {
  description = "The file system deployment type. Valid values: MULTI_AZ_1, SINGLE_AZ_1"
  type        = string
  default     = "MULTI_AZ_1"
}

variable "throughput_capacity" {
  description = "The sustained throughput in MBps of the file system"
  type        = number
}

variable "preferred_subnet_id" {
  description = "The preferred subnet ID for the file system in a MULTI_AZ_1 deployment"
  type        = string
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

variable "fsx_admin_password" {
  description = "The ONTAP administrative password for the fsxadmin user"
  type        = string
  default     = null
  sensitive   = true
}

variable "endpoint_ip_address_range" {
  description = "The IP address range for the endpoints in a MULTI_AZ_1 deployment, specified as CIDR notation"
  type        = string
  default     = null
}

variable "route_table_ids" {
  description = "List of route table IDs for the file system to use in a MULTI_AZ_1 deployment"
  type        = list(string)
  default     = []
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
# STORAGE VOLUMES
#==============================================================================

variable "storage_volumes" {
  description = "List of ONTAP volume configurations to create on the storage virtual machine"
  type = list(object({
    name                          = string
    size_in_megabytes             = number
    storage_efficiency_enabled    = optional(bool, true)
    junction_path                 = string
    security_style                = optional(string, "UNIX")
    tiering_policy_name           = optional(string)
    tiering_policy_cooling_period = optional(number)
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
