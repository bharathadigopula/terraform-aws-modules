#==============================================================================
# MEMORYDB CLUSTER VARIABLES
#==============================================================================
variable "name" {
  type        = string
  description = "Name of the MemoryDB cluster"
}

variable "description" {
  type        = string
  description = "Description of the MemoryDB cluster"
  default     = ""
}

variable "node_type" {
  type        = string
  description = "The compute and memory capacity of the nodes in the cluster"
}

variable "num_shards" {
  type        = number
  description = "Number of shards in the cluster"
  default     = 1
}

variable "num_replicas_per_shard" {
  type        = number
  description = "Number of replicas per shard"
  default     = 1
}

variable "acl_name" {
  type        = string
  description = "Name of the ACL to associate with the cluster"
}

variable "subnet_group_name" {
  type        = string
  description = "Name of the subnet group to use. If not provided and subnet_ids are given, a subnet group will be created"
  default     = null
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the MemoryDB subnet group"
  default     = []
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to associate with the cluster"
  default     = []
}

variable "port" {
  type        = number
  description = "Port number on which each node accepts connections"
  default     = 6379
}

variable "tls_enabled" {
  type        = bool
  description = "Whether to enable TLS encryption"
  default     = true
}

variable "kms_key_arn" {
  type        = string
  description = "ARN of the KMS key used to encrypt the cluster at rest"
  default     = null
}

variable "snapshot_retention_limit" {
  type        = number
  description = "Number of days for which MemoryDB retains automatic snapshots"
  default     = 7
}

variable "snapshot_window" {
  type        = string
  description = "Daily time range during which MemoryDB begins taking snapshots"
  default     = null
}

variable "maintenance_window" {
  type        = string
  description = "Weekly time range during which system maintenance can occur"
  default     = null
}

variable "engine_version" {
  type        = string
  description = "Version number of the Redis engine to be used for the cluster"
  default     = null
}

variable "parameter_group_name" {
  type        = string
  description = "Name of the parameter group associated with the cluster"
  default     = null
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Whether minor engine upgrades will be applied automatically during the maintenance window"
  default     = true
}

variable "sns_topic_arn" {
  type        = string
  description = "ARN of the SNS topic to send notifications to"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to assign to all resources"
  default     = {}
}
