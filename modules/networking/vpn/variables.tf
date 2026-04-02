#==============================================================================
# GENERAL
#==============================================================================

variable "name" {
  type        = string
  description = "Name prefix for all VPN resources"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to all resources"
}

#==============================================================================
# CUSTOMER GATEWAY
#==============================================================================

variable "customer_gateway_bgp_asn" {
  type        = number
  description = "BGP ASN of the customer gateway"
}

variable "customer_gateway_ip_address" {
  type        = string
  description = "Public IP address of the customer gateway device"
}

variable "customer_gateway_type" {
  type        = string
  default     = "ipsec.1"
  description = "Type of customer gateway"
}

#==============================================================================
# VPN GATEWAY
#==============================================================================

variable "create_vpn_gateway" {
  type        = bool
  default     = false
  description = "Whether to create a new VPN gateway"
}

variable "vpn_gateway_id" {
  type        = string
  default     = null
  description = "ID of an existing VPN gateway to use"
}

variable "vpc_id" {
  type        = string
  default     = null
  description = "VPC ID to attach the VPN gateway to"
}

variable "vpn_gateway_amazon_side_asn" {
  type        = number
  default     = 64512
  description = "ASN for the Amazon side of the VPN gateway"
}

#==============================================================================
# VPN CONNECTION
#==============================================================================

variable "static_routes_only" {
  type        = bool
  default     = false
  description = "Whether the VPN connection uses static routes only"
}

variable "local_ipv4_network_cidr" {
  type        = string
  default     = "0.0.0.0/0"
  description = "CIDR block of the local (AWS side) network"
}

variable "remote_ipv4_network_cidr" {
  type        = string
  default     = "0.0.0.0/0"
  description = "CIDR block of the remote (on-premises) network"
}

variable "static_routes_destinations" {
  type        = list(string)
  default     = []
  description = "List of CIDR blocks for static VPN routes"
}

variable "tunnel1_inside_cidr" {
  type        = string
  default     = null
  description = "Inside CIDR block for tunnel 1"
}

variable "tunnel2_inside_cidr" {
  type        = string
  default     = null
  description = "Inside CIDR block for tunnel 2"
}

variable "tunnel1_preshared_key" {
  type        = string
  default     = null
  sensitive   = true
  description = "Preshared key for tunnel 1"
}

variable "tunnel2_preshared_key" {
  type        = string
  default     = null
  sensitive   = true
  description = "Preshared key for tunnel 2"
}

#==============================================================================
# TRANSIT GATEWAY
#==============================================================================

variable "transit_gateway_id" {
  type        = string
  default     = null
  description = "Transit Gateway ID for TGW-based VPN attachment instead of VGW"
}

#==============================================================================
# ROUTE PROPAGATION
#==============================================================================

variable "enable_vpn_gateway_route_propagation" {
  type        = bool
  default     = false
  description = "Whether to enable VPN gateway route propagation"
}

variable "route_table_ids" {
  type        = list(string)
  default     = []
  description = "List of route table IDs to propagate VPN routes into"
}
