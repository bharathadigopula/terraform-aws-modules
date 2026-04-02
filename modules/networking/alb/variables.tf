#==============================================================================
# ALB CONFIGURATION
#==============================================================================

variable "name" {
  type        = string
  description = "Name of the Application Load Balancer"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the ALB and target groups will be created"
}

variable "subnets" {
  type        = list(string)
  description = "List of subnet IDs for the ALB"
}

variable "security_groups" {
  type        = list(string)
  default     = []
  description = "List of security group IDs to attach to the ALB"
}

variable "internal" {
  type        = bool
  default     = false
  description = "Whether the ALB is internal or internet-facing"
}

variable "idle_timeout" {
  type        = number
  default     = 60
  description = "Time in seconds that the connection is allowed to be idle"
}

variable "enable_deletion_protection" {
  type        = bool
  default     = true
  description = "Prevent the ALB from being deleted accidentally"
}

variable "enable_http2" {
  type        = bool
  default     = true
  description = "Enable HTTP/2 on the ALB"
}

variable "enable_cross_zone_load_balancing" {
  type        = bool
  default     = true
  description = "Enable cross-zone load balancing"
}

#==============================================================================
# ACCESS LOGS
#==============================================================================

variable "access_logs" {
  type = object({
    bucket  = string
    prefix  = optional(string, "")
    enabled = optional(bool, true)
  })
  default     = null
  description = "S3 bucket configuration for ALB access logs"
}

#==============================================================================
# LISTENERS
#==============================================================================

variable "listeners" {
  type = list(object({
    port            = number
    protocol        = string
    ssl_policy      = optional(string, "ELBSecurityPolicy-TLS13-1-2-2021-06")
    certificate_arn = optional(string, null)
    default_action = object({
      type             = string
      target_group_key = optional(number, null)
      redirect = optional(object({
        port        = optional(string, "443")
        protocol    = optional(string, "HTTPS")
        status_code = optional(string, "HTTP_301")
      }), null)
      fixed_response = optional(object({
        content_type = string
        message_body = optional(string, null)
        status_code  = optional(string, "200")
      }), null)
    })
  }))
  default     = []
  description = "List of listener configurations for the ALB"
}

#==============================================================================
# TARGET GROUPS
#==============================================================================

variable "target_groups" {
  type = list(object({
    name        = string
    port        = number
    protocol    = optional(string, "HTTP")
    target_type = optional(string, "ip")
    health_check = optional(object({
      enabled             = optional(bool, true)
      path                = optional(string, "/")
      port                = optional(string, "traffic-port")
      protocol            = optional(string, "HTTP")
      healthy_threshold   = optional(number, 3)
      unhealthy_threshold = optional(number, 3)
      timeout             = optional(number, 5)
      interval            = optional(number, 30)
      matcher             = optional(string, "200")
    }), {})
    stickiness = optional(object({
      type            = optional(string, "lb_cookie")
      enabled         = optional(bool, false)
      cookie_duration = optional(number, 86400)
      cookie_name     = optional(string, null)
    }), {})
    deregistration_delay = optional(number, 300)
  }))
  default     = []
  description = "List of target group configurations"
}

#==============================================================================
# TAGS
#==============================================================================

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to all resources created by this module"
}
