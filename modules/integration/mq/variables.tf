#==============================================================================
# BROKER VARIABLES
#==============================================================================
variable "broker_name" {
  description = "Name of the MQ broker"
  type        = string
}

variable "engine_type" {
  description = "Broker engine type (ActiveMQ or RabbitMQ)"
  type        = string
  default     = "RabbitMQ"
}

variable "engine_version" {
  description = "Broker engine version"
  type        = string
}

variable "host_instance_type" {
  description = "Broker instance type"
  type        = string
  default     = "mq.m5.large"
}

variable "deployment_mode" {
  description = "Deployment mode (SINGLE_INSTANCE, ACTIVE_STANDBY_MULTI_AZ, CLUSTER_MULTI_AZ)"
  type        = string
  default     = "SINGLE_INSTANCE"
}

variable "publicly_accessible" {
  description = "Whether the broker is publicly accessible"
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Whether to auto-upgrade minor versions"
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Whether to apply changes immediately"
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = "List of subnet IDs for the broker"
  type        = list(string)
  default     = []
}

variable "security_groups" {
  description = "List of security group IDs"
  type        = list(string)
  default     = []
}

variable "authentication_strategy" {
  description = "Authentication strategy (simple or ldap)"
  type        = string
  default     = "simple"
}

variable "kms_key_id" {
  description = "KMS key ID for encryption at rest"
  type        = string
  default     = null
}

#==============================================================================
# USER VARIABLES
#==============================================================================
variable "users" {
  description = "List of broker users"
  type = list(object({
    username       = string
    password       = string
    console_access = optional(bool, false)
    groups         = optional(list(string), [])
  }))
}

#==============================================================================
# LOGGING VARIABLES
#==============================================================================
variable "general_log_enabled" {
  description = "Whether general logging is enabled"
  type        = bool
  default     = true
}

variable "audit_log_enabled" {
  description = "Whether audit logging is enabled (ActiveMQ only)"
  type        = bool
  default     = true
}

#==============================================================================
# MAINTENANCE VARIABLES
#==============================================================================
variable "maintenance_day_of_week" {
  description = "Day of week for maintenance window"
  type        = string
  default     = "SUNDAY"
}

variable "maintenance_time_of_day" {
  description = "Time of day for maintenance window (HH:MM)"
  type        = string
  default     = "03:00"
}

variable "maintenance_time_zone" {
  description = "Time zone for maintenance window"
  type        = string
  default     = "UTC"
}

#==============================================================================
# CONFIGURATION VARIABLES
#==============================================================================
variable "configuration_data" {
  description = "Broker configuration XML data"
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
