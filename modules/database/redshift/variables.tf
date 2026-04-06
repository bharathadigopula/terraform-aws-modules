#==============================================================================
# CLUSTER CONFIGURATION
#==============================================================================

variable "cluster_identifier" {
  description = "Unique identifier for the Redshift cluster"
  type        = string
}

variable "node_type" {
  description = "Node type for the Redshift cluster (e.g. dc2.large, ra3.xlplus)"
  type        = string
}

variable "number_of_nodes" {
  description = "Number of compute nodes in the cluster"
  type        = number
  default     = 2
}

variable "database_name" {
  description = "Name of the default database to create"
  type        = string
}

variable "master_username" {
  description = "Master username for the cluster"
  type        = string
}

variable "master_password" {
  description = "Master password for the cluster"
  type        = string
  sensitive   = true
}

variable "port" {
  description = "Port number on which the cluster accepts connections"
  type        = number
  default     = 5439
}

#==============================================================================
# NETWORK CONFIGURATION
#==============================================================================

variable "cluster_subnet_group_name" {
  description = "Name of the cluster subnet group"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs to associate with the cluster"
  type        = list(string)
  default     = []
}

variable "publicly_accessible" {
  description = "Whether the cluster can be accessed from a public network"
  type        = bool
  default     = false
}

variable "enhanced_vpc_routing" {
  description = "Whether enhanced VPC routing is enabled for the cluster"
  type        = bool
  default     = true
}

variable "elastic_ip" {
  description = "Elastic IP address for the cluster"
  type        = string
  default     = null
}

#==============================================================================
# ENCRYPTION CONFIGURATION
#==============================================================================

variable "encrypted" {
  description = "Whether the data in the cluster is encrypted at rest"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "ARN of the KMS key used to encrypt the cluster"
  type        = string
  default     = null
}

#==============================================================================
# PARAMETER GROUP AND IAM
#==============================================================================

variable "cluster_parameter_group_name" {
  description = "Name of the parameter group to associate with the cluster"
  type        = string
  default     = null
}

variable "iam_roles" {
  description = "List of IAM role ARNs to associate with the cluster"
  type        = list(string)
  default     = []
}

#==============================================================================
# SNAPSHOT CONFIGURATION
#==============================================================================

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot before cluster deletion"
  type        = bool
  default     = false
}

variable "final_snapshot_identifier" {
  description = "Identifier of the final snapshot to create before cluster deletion"
  type        = string
  default     = null
}

variable "automated_snapshot_retention_period" {
  description = "Number of days to retain automated snapshots"
  type        = number
  default     = 7
}

#==============================================================================
# MAINTENANCE CONFIGURATION
#==============================================================================

variable "preferred_maintenance_window" {
  description = "Preferred maintenance window for the cluster (e.g. sun:05:00-sun:06:00)"
  type        = string
  default     = null
}

#==============================================================================
# LOGGING CONFIGURATION
#==============================================================================

variable "logging" {
  description = "Logging configuration for the Redshift cluster"
  type = object({
    enable               = bool
    log_destination_type = optional(string, null)
    bucket_name          = optional(string, null)
    s3_key_prefix        = optional(string, null)
  })
  default = null
}

#==============================================================================
# TAGS
#==============================================================================

variable "tags" {
  description = "Map of tags to assign to all resources"
  type        = map(string)
  default     = {}
}
