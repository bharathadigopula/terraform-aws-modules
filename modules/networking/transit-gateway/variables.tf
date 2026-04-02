#==============================================================================
# TRANSIT GATEWAY CONFIGURATION
#==============================================================================

variable "name" {
  type        = string
  description = "Name of the Transit Gateway"
}

variable "description" {
  type        = string
  default     = ""
  description = "Description of the Transit Gateway"
}

variable "amazon_side_asn" {
  type        = number
  default     = 64512
  description = "Private ASN for the Amazon side of the Transit Gateway"
}

variable "auto_accept_shared_attachments" {
  type        = string
  default     = "disable"
  description = "Whether resource attachment requests are automatically accepted"
}

variable "default_route_table_association" {
  type        = string
  default     = "enable"
  description = "Whether resource attachments are automatically associated with the default route table"
}

variable "default_route_table_propagation" {
  type        = string
  default     = "enable"
  description = "Whether resource attachments automatically propagate routes to the default route table"
}

variable "dns_support" {
  type        = string
  default     = "enable"
  description = "Whether DNS support is enabled on the Transit Gateway"
}

variable "vpn_ecmp_support" {
  type        = string
  default     = "enable"
  description = "Whether VPN Equal Cost Multipath Protocol support is enabled"
}

variable "transit_gateway_cidr_blocks" {
  type        = list(string)
  default     = []
  description = "One or more IPv4 or IPv6 CIDR blocks for the Transit Gateway"
}

#==============================================================================
# VPC ATTACHMENTS
#==============================================================================

variable "vpc_attachments" {
  type = map(object({
    vpc_id                                          = string
    subnet_ids                                      = list(string)
    dns_support                                     = optional(string, "enable")
    appliance_mode_support                          = optional(string, "disable")
    transit_gateway_default_route_table_association = optional(bool, true)
    transit_gateway_default_route_table_propagation = optional(bool, true)
  }))
  default     = {}
  description = "Map of VPC attachment definitions"
}

#==============================================================================
# ROUTE TABLE ROUTES
#==============================================================================

variable "route_table_routes" {
  type = list(object({
    destination_cidr_block      = string
    transit_gateway_attachment_id = optional(string, null)
    blackhole                   = optional(bool, false)
  }))
  default     = []
  description = "List of route entries for the Transit Gateway route table"
}

#==============================================================================
# RAM SHARING
#==============================================================================

variable "ram_share_enabled" {
  type        = bool
  default     = false
  description = "Whether to create a Resource Access Manager share for the Transit Gateway"
}

variable "ram_principals" {
  type        = list(string)
  default     = []
  description = "List of principal ARNs or account IDs to share the Transit Gateway with via RAM"
}

#==============================================================================
# TAGS
#==============================================================================

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Map of tags to assign to all resources"
}
