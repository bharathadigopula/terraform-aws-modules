#==============================================================================
# NEPTUNE CLUSTER VARIABLES
#==============================================================================
variable "cluster_identifier" {
  type        = string
  description = "The cluster identifier for the Neptune cluster"
}

variable "engine_version" {
  type        = string
  description = "The Neptune engine version"
  default     = null
}

variable "instance_class" {
  type        = string
  description = "The instance class to use for Neptune cluster instances"
}

variable "instances" {
  type        = number
  description = "Number of Neptune cluster instances to create"
  default     = 2
}

variable "db_subnet_group_name" {
  type        = string
  description = "Name of the DB subnet group to associate with this cluster"
  default     = null
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of VPC security group IDs to associate with the cluster"
  default     = []
}

variable "port" {
  type        = number
  description = "Port on which Neptune accepts connections"
  default     = 8182
}

variable "storage_encrypted" {
  type        = bool
  description = "Whether the Neptune cluster storage is encrypted"
  default     = true
}

variable "kms_key_id" {
  type        = string
  description = "ARN of the KMS key to encrypt the cluster storage"
  default     = null
}

variable "backup_retention_period" {
  type        = number
  description = "Number of days to retain backups"
  default     = 7
}

variable "preferred_backup_window" {
  type        = string
  description = "Daily time range during which automated backups are created"
  default     = null
}

variable "preferred_maintenance_window" {
  type        = string
  description = "Weekly time range during which system maintenance can occur"
  default     = null
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Whether a final snapshot is created before the cluster is deleted"
  default     = false
}

variable "deletion_protection" {
  type        = bool
  description = "Whether deletion protection is enabled on the cluster"
  default     = true
}

variable "iam_database_authentication_enabled" {
  type        = bool
  description = "Whether IAM database authentication is enabled"
  default     = true
}

variable "enable_cloudwatch_logs_exports" {
  type        = list(string)
  description = "List of log types to export to CloudWatch"
  default     = ["audit"]
}

variable "apply_immediately" {
  type        = bool
  description = "Whether cluster modifications are applied immediately or during the next maintenance window"
  default     = false
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Whether minor engine upgrades are applied automatically during the maintenance window"
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to assign to all resources"
  default     = {}
}
