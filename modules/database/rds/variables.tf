#==============================================================================
# RDS Instance Variables
#==============================================================================

variable "identifier" {
  description = "The name of the RDS instance"
  type        = string
}

variable "engine" {
  description = "The database engine to use (mysql, postgres, mariadb)"
  type        = string

  validation {
    condition     = contains(["mysql", "postgres", "mariadb"], var.engine)
    error_message = "Engine must be one of: mysql, postgres, mariadb."
  }
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
}

variable "max_allocated_storage" {
  description = "The upper limit to which Amazon RDS can automatically scale the storage"
  type        = number
  default     = null
}

variable "storage_type" {
  description = "The storage type for the RDS instance"
  type        = string
  default     = "gp3"
}

variable "storage_encrypted" {
  description = "Whether the DB instance is encrypted"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key"
  type        = string
  default     = null
}

variable "db_name" {
  description = "The name of the database to create when the DB instance is created"
  type        = string
  default     = null
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
}

variable "password" {
  description = "Password for the master DB user"
  type        = string
  sensitive   = true
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = number
  default     = null
}

variable "multi_az" {
  description = "Whether the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = []
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate"
  type        = string
  default     = null
}

variable "option_group_name" {
  description = "Name of the DB option group to associate"
  type        = string
  default     = null
}

variable "publicly_accessible" {
  description = "Whether the database instance is publicly accessible"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Whether a final DB snapshot is created before the DB instance is deleted"
  type        = bool
  default     = false
}

variable "final_snapshot_identifier" {
  description = "The name of the final DB snapshot when the DB instance is deleted"
  type        = string
  default     = null
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "The daily time range during which automated backups are created"
  type        = string
  default     = null
}

variable "maintenance_window" {
  description = "The window to perform maintenance in"
  type        = string
  default     = null
}

variable "auto_minor_version_upgrade" {
  description = "Whether minor engine upgrades will be applied automatically during the maintenance window"
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Whether deletion protection is enabled on the DB instance"
  type        = bool
  default     = true
}

variable "monitoring_interval" {
  description = "The interval in seconds between points when Enhanced Monitoring metrics are collected"
  type        = number
  default     = 60
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
  type        = string
  default     = null
}

variable "performance_insights_enabled" {
  description = "Whether Performance Insights is enabled"
  type        = bool
  default     = true
}

variable "performance_insights_kms_key_id" {
  description = "The ARN for the KMS key to encrypt Performance Insights data"
  type        = string
  default     = null
}

variable "performance_insights_retention_period" {
  description = "The number of days to retain Performance Insights data"
  type        = number
  default     = 7
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to enable for exporting to CloudWatch Logs"
  type        = list(string)
  default     = []
}

variable "copy_tags_to_snapshot" {
  description = "Whether to copy all instance tags to snapshots"
  type        = bool
  default     = true
}

variable "iam_database_authentication_enabled" {
  description = "Whether to enable IAM database authentication"
  type        = bool
  default     = false
}

variable "apply_immediately" {
  description = "Whether database modifications are applied immediately or during the next maintenance window"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
