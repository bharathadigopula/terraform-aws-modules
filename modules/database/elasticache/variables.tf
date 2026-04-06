#==============================================================================
# ELASTICACHE REPLICATION GROUP IDENTIFICATION
#==============================================================================


variable "replication_group_id" {
  description = "Unique identifier for the replication group"
  type        = string
}

variable "description" {
  description = "Description of the replication group"
  type        = string
}

#==============================================================================
# ENGINE CONFIGURATION
#==============================================================================

variable "engine" {
  description = "Cache engine to use. Valid values are redis and memcached"
  type        = string
}

variable "engine_version" {
  description = "Version number of the cache engine"
  type        = string
  default     = null
}

variable "node_type" {
  description = "Instance class for the cache nodes"
  type        = string
}

#==============================================================================
# CLUSTER SIZING
#==============================================================================

variable "num_cache_nodes" {
  description = "Number of cache nodes for memcached clusters"
  type        = number
  default     = null
}

variable "num_node_groups" {
  description = "Number of node groups (shards) for Redis cluster mode enabled"
  type        = number
  default     = null
}

variable "replicas_per_node_group" {
  description = "Number of replica nodes in each node group for Redis cluster mode"
  type        = number
  default     = null
}

#==============================================================================
# NETWORK
#==============================================================================

variable "port" {
  description = "Port number on which the cache accepts connections"
  type        = number
  default     = 6379
}

variable "parameter_group_name" {
  description = "Name of the parameter group to associate with the replication group"
  type        = string
  default     = null
}

variable "subnet_group_name" {
  description = "Name of the subnet group to associate with the replication group"
  type        = string
  default     = null
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the replication group"
  type        = list(string)
  default     = []
}

#==============================================================================
# ENCRYPTION
#==============================================================================

variable "at_rest_encryption_enabled" {
  description = "Enable encryption at rest for the replication group"
  type        = bool
  default     = true
}

variable "transit_encryption_enabled" {
  description = "Enable encryption in transit for the replication group"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "ARN of the KMS key for encrypting data at rest"
  type        = string
  default     = null
}

variable "auth_token" {
  description = "Auth token for Redis AUTH when transit encryption is enabled"
  type        = string
  default     = null
  sensitive   = true
}

#==============================================================================
# HIGH AVAILABILITY
#==============================================================================

variable "automatic_failover_enabled" {
  description = "Enable automatic failover for the replication group"
  type        = bool
  default     = true
}

variable "multi_az_enabled" {
  description = "Enable Multi-AZ support for the replication group"
  type        = bool
  default     = false
}

#==============================================================================
# BACKUP AND MAINTENANCE
#==============================================================================

variable "snapshot_retention_limit" {
  description = "Number of days to retain automatic snapshots before deleting them"
  type        = number
  default     = 7
}

variable "snapshot_window" {
  description = "Daily time range during which automated backups are created (e.g. 05:00-09:00)"
  type        = string
  default     = null
}

variable "maintenance_window" {
  description = "Weekly time range for maintenance operations (e.g. sun:05:00-sun:06:00)"
  type        = string
  default     = null
}

#==============================================================================
# NOTIFICATIONS AND UPGRADES
#==============================================================================

variable "notification_topic_arn" {
  description = "ARN of the SNS topic for ElastiCache notifications"
  type        = string
  default     = null
}

variable "auto_minor_version_upgrade" {
  description = "Enable automatic minor version upgrades during maintenance windows"
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Apply changes immediately instead of during the next maintenance window"
  type        = bool
  default     = null
}

variable "final_snapshot_identifier" {
  description = "Name of the final snapshot to create before deleting the replication group"
  type        = string
  default     = null
}

#==============================================================================
# LOG DELIVERY
#==============================================================================

variable "log_delivery_configuration" {
  description = "List of log delivery configurations for the replication group"
  type = list(object({
    destination      = string
    destination_type = string
    log_format       = string
    log_type         = string
  }))
  default = []
}

#==============================================================================
# TAGS
#==============================================================================

variable "tags" {
  description = "Map of tags to assign to the replication group"
  type        = map(string)
  default     = {}
}
