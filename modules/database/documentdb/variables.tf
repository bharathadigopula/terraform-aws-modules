#==============================================================================
# DOCUMENTDB CLUSTER VARIABLES
#==============================================================================

variable "cluster_identifier" {
  description = "The cluster identifier for the DocumentDB cluster"
  type        = string
}

variable "engine_version" {
  description = "The engine version for the DocumentDB cluster"
  type        = string
}

variable "instance_class" {
  description = "The instance class for DocumentDB cluster instances"
  type        = string
}

variable "instances" {
  description = "Number of DocumentDB cluster instances to create"
  type        = number
  default     = 2
}

variable "db_subnet_group_name" {
  description = "The DB subnet group name to associate with the cluster"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs to associate with the cluster"
  type        = list(string)
}

variable "port" {
  description = "The port on which the DocumentDB cluster accepts connections"
  type        = number
  default     = 27017
}

variable "master_username" {
  description = "The master username for the DocumentDB cluster"
  type        = string
}

variable "master_password" {
  description = "The master password for the DocumentDB cluster"
  type        = string
  sensitive   = true
}

variable "storage_encrypted" {
  description = "Whether the DocumentDB cluster storage is encrypted"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "The ARN of the KMS key used to encrypt the cluster storage"
  type        = string
  default     = null
}

variable "backup_retention_period" {
  description = "The number of days to retain backups"
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
  description = "Whether to skip the final snapshot when the cluster is deleted"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Whether deletion protection is enabled for the cluster"
  type        = bool
  default     = false
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to export to CloudWatch Logs"
  type        = list(string)
  default     = ["audit", "profiler"]
}

variable "apply_immediately" {
  description = "Whether changes should be applied immediately or during the next maintenance window"
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Whether minor engine upgrades are applied automatically during the maintenance window"
  type        = bool
  default     = true
}

variable "db_cluster_parameter_group_name" {
  description = "The name of the DB cluster parameter group to associate with the cluster"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the DocumentDB resources"
  type        = map(string)
  default     = {}
}
