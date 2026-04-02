#==============================================================================
# ZONE CONFIGURATION
#==============================================================================

variable "create_zone" {
  type    = bool
  default = true
}

variable "zone_name" {
  type = string
}

variable "comment" {
  type    = string
  default = ""
}

variable "force_destroy" {
  type    = bool
  default = false
}

variable "delegation_set_id" {
  type    = string
  default = null
}

#==============================================================================
# PRIVATE ZONE - VPC ASSOCIATIONS
#==============================================================================

variable "vpc_associations" {
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
  type    = map(string)
  default = {}
}
