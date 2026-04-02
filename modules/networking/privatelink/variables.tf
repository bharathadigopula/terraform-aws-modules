#==============================================================================
# VPC CONFIGURATION
#==============================================================================

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where endpoints will be created"
}

#==============================================================================
# GATEWAY ENDPOINTS
#==============================================================================

variable "gateway_endpoints" {
  type = map(object({
    service_name    = string
    route_table_ids = optional(list(string), [])
    policy          = optional(string, null)
  }))
  default     = {}
  description = "Map of gateway VPC endpoints to create (e.g. S3, DynamoDB)"
}

#==============================================================================
# INTERFACE ENDPOINTS
#==============================================================================

variable "interface_endpoints" {
  type = map(object({
    service_name        = string
    subnet_ids          = optional(list(string), [])
    security_group_ids  = optional(list(string), [])
    private_dns_enabled = optional(bool, true)
    policy              = optional(string, null)
  }))
  default     = {}
  description = "Map of interface VPC endpoints to create"
}

#==============================================================================
# TAGS
#==============================================================================

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to all resources"
}
