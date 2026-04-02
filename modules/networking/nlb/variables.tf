#==============================================================================
# GENERAL
#==============================================================================

variable "name" {
  description = "Name of the Network Load Balancer"
  type        = string
}

variable "internal" {
  description = "Whether the NLB is internal or internet-facing"
  type        = bool
  default     = true
}

variable "subnets" {
  description = "List of subnet IDs for the NLB"
  type        = list(string)
  default     = []
}

variable "enable_deletion_protection" {
  description = "Prevent the NLB from being deleted via the API"
  type        = bool
  default     = true
}

variable "enable_cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing"
  type        = bool
  default     = true
}

#==============================================================================
# SUBNET MAPPINGS
#==============================================================================

variable "subnet_mappings" {
  description = "List of subnet mapping configurations for static IP / EIP support"
  type = list(object({
    subnet_id            = string
    allocation_id        = optional(string)
    private_ipv4_address = optional(string)
  }))
  default = []
}

#==============================================================================
# ACCESS LOGS
#==============================================================================

variable "access_logs" {
  description = "Access log configuration for the NLB"
  type = object({
    bucket  = string
    prefix  = optional(string, "")
    enabled = optional(bool, true)
  })
  default = null
}

#==============================================================================
# TARGET GROUPS
#==============================================================================

variable "target_groups" {
  description = "List of target group configurations"
  type = list(object({
    name                = string
    port                = number
    protocol            = string
    target_type         = optional(string, "ip")
    deregistration_delay = optional(number, 300)
    preserve_client_ip  = optional(bool, null)
    health_check = optional(object({
      enabled             = optional(bool, true)
      protocol            = optional(string, "TCP")
      port                = optional(string, "traffic-port")
      path                = optional(string, null)
      interval            = optional(number, 30)
      healthy_threshold   = optional(number, 3)
      unhealthy_threshold = optional(number, 3)
    }), {})
  }))
  default = []
}

#==============================================================================
# LISTENERS
#==============================================================================

variable "listeners" {
  description = "List of listener configurations. The recommended ssl_policy for TLS listeners is ELBSecurityPolicy-TLS13-1-2-2021-06 (set as default)."
  type = list(object({
    port            = number
    protocol        = string
    default_action  = optional(string, "forward")
    ssl_policy      = optional(string, "ELBSecurityPolicy-TLS13-1-2-2021-06")
    certificate_arn = optional(string, null)
  }))
  default = []
}

#==============================================================================
# TAGS
#==============================================================================

variable "tags" {
  description = "Map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}
