#==============================================================================
# Aurora Cluster Variables
#==============================================================================

variable "cluster_identifier" {
  description = "The cluster identifier for the Aurora cluster"
  type        = string
}

variable "engine" {
  description = "The Aurora engine to use (aurora-mysql, aurora-postgresql)"
  type        = string

  validation {
    condition     = contains(["aurora-mysql", "aurora-postgresql"], var.engine)
    error_message = "Engine must be one of: aurora-mysql, aurora-postgresql."
  }
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
}

variable "engine_mode" {
  description = "The database engine mode (provisioned, serverless)"
  type        = string
  default     = "provisioned"
}

variable "instance_class" {
  description = "The instance class for Aurora cluster instances"
  type        = string
}

variable "instances" {
  description = "Number of cluster instances to create"
  type        = number
  default     = 2
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group for the cluster"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate with the cluster"
  type        = list(string)
  default     = []
}

variable "database_name" {
  description = "Name for an automatically created database on cluster creation"
  type        = string
  default     = null
}

variable "master_username" {
  description = "Username for the master DB user"
  type        = string
}

variable "master_password" {
  description = "Password for the master DB user"
  type        = string
  sensitive   = true
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = number
  default     = null
}

variable "storage_encrypted" {
  description = "Whether the DB cluster is encrypted"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key"
  type        = string
  default     = null
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 7
}

variable "preferred_backup_window" {
  description = "The daily time range during which automated backups are created"
  type        = string
  default     = null
}

variable "preferred_maintenance_window" {
  description = "The weekly time range during which system maintenance can occur"
  type        = string
  default     = null
}

variable "skip_final_snapshot" {
  description = "Whether a final DB snapshot is created before the cluster is deleted"
  type        = bool
  default     = false
}

variable "final_snapshot_identifier" {
  description = "The name of the final DB snapshot when the cluster is deleted"
  type        = string
  default     = null
}

variable "deletion_protection" {
  description = "Whether deletion protection is enabled on the cluster"
  type        = bool
  default     = true
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to export to CloudWatch Logs"
  type        = list(string)
  default     = []
}

variable "iam_database_authentication_enabled" {
  description = "Whether to enable IAM database authentication"
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Whether cluster modifications are applied immediately or during the next maintenance window"
  type        = bool
  default     = false
}

variable "serverlessv2_scaling_configuration" {
  description = "Serverless v2 scaling configuration with min_capacity and max_capacity"
  type = object({
    min_capacity = number
    max_capacity = number
  })
  default = null
}

variable "auto_minor_version_upgrade" {
  description = "Whether minor engine upgrades will be applied automatically during the maintenance window"
  type        = bool
  default     = true
}

variable "performance_insights_enabled" {
  description = "Whether Performance Insights is enabled for cluster instances"
  type        = bool
  default     = true
}

variable "performance_insights_kms_key_id" {
  description = "The ARN for the KMS key to encrypt Performance Insights data"
  type        = string
  default     = null
}

variable "copy_tags_to_snapshot" {
  description = "Whether to copy all cluster tags to snapshots"
  type        = bool
  default     = true
}

variable "monitoring_interval" {
  description = "Interval in seconds for enhanced monitoring (0 to disable, 1/5/10/15/30/60)"
  type        = number
  default     = 60
}

variable "monitoring_role_arn" {
  description = "IAM role ARN for RDS enhanced monitoring"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}
