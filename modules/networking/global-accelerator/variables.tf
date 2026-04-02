#==============================================================================
# ACCELERATOR CONFIGURATION
#==============================================================================

variable "name" {
  type        = string
  description = "Name of the Global Accelerator"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Whether the accelerator is enabled"
}

variable "ip_address_type" {
  type        = string
  default     = "IPV4"
  description = "IP address type - IPV4 or DUAL_STACK"
}

variable "ip_addresses" {
  type        = list(string)
  default     = []
  description = "IP addresses to use for the accelerator"
}

#==============================================================================
# FLOW LOGS CONFIGURATION
#==============================================================================

variable "flow_logs_enabled" {
  type        = bool
  default     = true
  description = "Whether flow logs are enabled for the accelerator"
}

variable "flow_logs_s3_bucket" {
  type        = string
  default     = null
  description = "S3 bucket for flow logs"
}

variable "flow_logs_s3_prefix" {
  type        = string
  default     = null
  description = "S3 prefix for flow logs"
}

#==============================================================================
# LISTENER CONFIGURATION
#==============================================================================

variable "listeners" {
  type = list(object({
    port_ranges = list(object({
      from_port = number
      to_port   = number
    }))
    protocol        = string
    client_affinity = optional(string, "NONE")
  }))
  default     = []
  description = "List of listener configurations"
}

#==============================================================================
# ENDPOINT GROUP CONFIGURATION
#==============================================================================

variable "endpoint_groups" {
  type = list(object({
    listener_index                = number
    endpoint_group_region         = optional(string, null)
    health_check_port             = optional(number, null)
    health_check_protocol         = optional(string, null)
    health_check_path             = optional(string, null)
    health_check_interval_seconds = optional(number, 30)
    threshold_count               = optional(number, 3)
    traffic_dial_percentage       = optional(number, 100)
    endpoint_configurations = optional(list(object({
      endpoint_id                    = string
      weight                         = optional(number, 128)
      client_ip_preservation_enabled = optional(bool, true)
    })), [])
  }))
  default     = []
  description = "List of endpoint group configurations"
}

#==============================================================================
# TAGS
#==============================================================================

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to all resources"
}
