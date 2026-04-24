#==============================================================================
# DOMAIN VARIABLES
#==============================================================================
variable "domain_name" {
  description = "Name of the OpenSearch domain"
  type        = string
}

variable "engine_version" {
  description = "OpenSearch/Elasticsearch engine version"
  type        = string
  default     = "OpenSearch_2.15"
}

#==============================================================================
# CLUSTER VARIABLES
#==============================================================================
variable "instance_type" {
  description = "Instance type for data nodes"
  type        = string
  default     = "t3.small.search"
}

variable "instance_count" {
  description = "Number of data node instances"
  type        = number
  default     = 2
}

variable "zone_awareness_enabled" {
  description = "Whether zone awareness is enabled"
  type        = bool
  default     = true
}

variable "availability_zone_count" {
  description = "Number of availability zones (2 or 3)"
  type        = number
  default     = 2
}

variable "dedicated_master_enabled" {
  description = "Whether dedicated master nodes are enabled"
  type        = bool
  default     = false
}

variable "dedicated_master_type" {
  description = "Instance type for dedicated master nodes"
  type        = string
  default     = "t3.small.search"
}

variable "dedicated_master_count" {
  description = "Number of dedicated master nodes"
  type        = number
  default     = 3
}

variable "warm_enabled" {
  description = "Whether UltraWarm nodes are enabled"
  type        = bool
  default     = false
}

variable "warm_type" {
  description = "UltraWarm instance type"
  type        = string
  default     = "ultrawarm1.medium.search"
}

variable "warm_count" {
  description = "Number of UltraWarm nodes"
  type        = number
  default     = 2
}

#==============================================================================
# EBS VARIABLES
#==============================================================================
variable "volume_type" {
  description = "EBS volume type (gp3, gp2, io1)"
  type        = string
  default     = "gp3"
}

variable "volume_size" {
  description = "EBS volume size per node (GB)"
  type        = number
  default     = 50
}

variable "volume_iops" {
  description = "EBS IOPS"
  type        = number
  default     = null
}

variable "volume_throughput" {
  description = "EBS throughput (MB/s) for gp3"
  type        = number
  default     = null
}

#==============================================================================
# ENCRYPTION VARIABLES
#==============================================================================
variable "kms_key_id" {
  description = "KMS key ID for encryption at rest"
  type        = string
  default     = null
}

variable "tls_security_policy" {
  description = "TLS security policy"
  type        = string
  default     = "Policy-Min-TLS-1-2-PFS-2023-10"
}

variable "custom_endpoint_enabled" {
  description = "Whether custom endpoint is enabled"
  type        = bool
  default     = false
}

variable "custom_endpoint" {
  description = "Fully qualified domain for custom endpoint"
  type        = string
  default     = null
}

variable "custom_endpoint_certificate_arn" {
  description = "ACM certificate ARN for custom endpoint"
  type        = string
  default     = null
}

#==============================================================================
# VPC VARIABLES
#==============================================================================
variable "subnet_ids" {
  description = "List of subnet IDs for VPC deployment"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
  default     = []
}

#==============================================================================
# FINE-GRAINED ACCESS CONTROL VARIABLES
#==============================================================================
variable "enable_fine_grained_access_control" {
  description = "Enable fine-grained access control"
  type        = bool
  default     = false
}

variable "internal_user_database_enabled" {
  description = "Enable internal user database"
  type        = bool
  default     = false
}

variable "master_user_arn" {
  description = "Master user IAM ARN"
  type        = string
  default     = null
}

variable "master_user_name" {
  description = "Master user name"
  type        = string
  default     = null
}

variable "master_user_password" {
  description = "Master user password"
  type        = string
  default     = null
  sensitive   = true
}

#==============================================================================
# LOGGING VARIABLES
#==============================================================================
variable "log_publishing_options" {
  description = "List of log publishing options"
  type = list(object({
    log_type                 = string
    cloudwatch_log_group_arn = string
    enabled                  = optional(bool, true)
  }))
  default = []
}

#==============================================================================
# SNAPSHOT VARIABLES
#==============================================================================
variable "automated_snapshot_start_hour" {
  description = "Hour of the day to start automated snapshots (UTC)"
  type        = number
  default     = 0
}

#==============================================================================
# POLICY VARIABLES
#==============================================================================
variable "access_policies" {
  description = "Access policy JSON"
  type        = string
  default     = null
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
