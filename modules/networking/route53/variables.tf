#==============================================================================
# ZONE CONFIGURATION
#==============================================================================

variable "create_zone" {
  description = "Whether to create the Route53 hosted zone"
  type        = bool
  default     = true
}

variable "zone_name" {
  description = "Name of the Route53 hosted zone"
  type        = string
}

variable "comment" {
  description = "Comment for the Route53 hosted zone"
  type        = string
  default     = ""
}

variable "force_destroy" {
  description = "Whether to force destroy the zone and all associated records"
  type        = bool
  default     = false
}

variable "delegation_set_id" {
  description = "ID of the reusable delegation set to assign to the hosted zone"
  type        = string
  default     = null
}

#==============================================================================
# PRIVATE ZONE - VPC ASSOCIATIONS
#==============================================================================

variable "vpc_associations" {
  description = "List of VPCs to associate with a private hosted zone"
  type = list(object({
    vpc_id     = string
    vpc_region = optional(string, null)
  }))
  default = []
}

#==============================================================================
# DNS RECORDS
#==============================================================================

variable "records" {
  description = "List of DNS record objects to create in the hosted zone"
  type = list(object({
    name = string
    type = string
    ttl  = optional(number, null)

    records = optional(list(string), [])

    alias = optional(object({
      name                   = string
      zone_id                = string
      evaluate_target_health = optional(bool, true)
    }), null)

    set_identifier = optional(string, null)

    weighted_routing_policy = optional(object({
      weight = number
    }), null)

    latency_routing_policy = optional(object({
      region = string
    }), null)

    failover_routing_policy = optional(object({
      type = string
    }), null)

    geolocation_routing_policy = optional(object({
      continent   = optional(string, null)
      country     = optional(string, null)
      subdivision = optional(string, null)
    }), null)

    health_check_id = optional(string, null)
  }))
  default = []
}

#==============================================================================
# HEALTH CHECKS
#==============================================================================

variable "health_checks" {
  description = "List of Route53 health check configurations"
  type = list(object({
    fqdn              = string
    port              = optional(number, 443)
    type              = optional(string, "HTTPS")
    resource_path     = optional(string, "/")
    failure_threshold = optional(number, 3)
    request_interval  = optional(number, 30)
    search_string     = optional(string, null)
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
