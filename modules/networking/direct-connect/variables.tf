#==============================================================================
# CONNECTION VARIABLES
#==============================================================================

variable "name" {
  description = "Name prefix for Direct Connect resources"
  type        = string
}

variable "create_connection" {
  description = "Whether to create a new DX connection or use an existing one"
  type        = bool
  default     = false
}

variable "connection_bandwidth" {
  description = "Bandwidth of the DX connection (e.g. 1Gbps, 10Gbps)"
  type        = string
  default     = "1Gbps"
}

variable "connection_location" {
  description = "AWS Direct Connect location where the connection is created"
  type        = string
  default     = ""
}

variable "connection_provider_name" {
  description = "Name of the service provider associated with the connection"
  type        = string
  default     = ""
}

variable "dx_connection_id" {
  description = "ID of an existing DX connection to use when create_connection is false"
  type        = string
  default     = ""
}

#==============================================================================
# DX GATEWAY VARIABLES
#==============================================================================

variable "dx_gateway_name" {
  description = "Name of the Direct Connect gateway"
  type        = string
  default     = ""
}

variable "dx_gateway_asn" {
  description = "ASN for the Amazon side of the DX gateway"
  type        = number
  default     = 64512
}

#==============================================================================
# GATEWAY ASSOCIATION VARIABLES
#==============================================================================

variable "associated_gateway_id" {
  description = "ID of the VGW or Transit Gateway to associate with the DX gateway"
  type        = string
  default     = ""
}

variable "allowed_prefixes" {
  description = "List of CIDR prefixes allowed to be advertised over the DX gateway association"
  type        = list(string)
  default     = []
}

#==============================================================================
# PRIVATE VIRTUAL INTERFACE VARIABLES
#==============================================================================

variable "create_private_virtual_interface" {
  description = "Whether to create a private virtual interface"
  type        = bool
  default     = false
}

variable "private_vif_name" {
  description = "Name of the private virtual interface"
  type        = string
  default     = ""
}

variable "private_vif_vlan" {
  description = "VLAN ID for the private virtual interface"
  type        = number
  default     = 0
}

variable "private_vif_bgp_asn" {
  description = "BGP ASN for the customer side of the private virtual interface"
  type        = number
  default     = 65000
}

variable "private_vif_address_family" {
  description = "Address family for the private VIF BGP peer (ipv4 or ipv6)"
  type        = string
  default     = "ipv4"
}

variable "private_vif_amazon_address" {
  description = "IPv4 CIDR address to use on the Amazon side of the private VIF"
  type        = string
  default     = ""
}

variable "private_vif_customer_address" {
  description = "IPv4 CIDR address to use on the customer side of the private VIF"
  type        = string
  default     = ""
}

variable "private_vif_mtu" {
  description = "MTU size for the private virtual interface (1500 or 9001)"
  type        = number
  default     = 1500
}

#==============================================================================
# TRANSIT VIRTUAL INTERFACE VARIABLES
#==============================================================================

variable "create_transit_virtual_interface" {
  description = "Whether to create a transit virtual interface"
  type        = bool
  default     = false
}

variable "transit_vif_name" {
  description = "Name of the transit virtual interface"
  type        = string
  default     = ""
}

variable "transit_vif_vlan" {
  description = "VLAN ID for the transit virtual interface"
  type        = number
  default     = 0
}

variable "transit_vif_bgp_asn" {
  description = "BGP ASN for the customer side of the transit virtual interface"
  type        = number
  default     = 65000
}

variable "transit_vif_address_family" {
  description = "Address family for the transit VIF BGP peer (ipv4 or ipv6)"
  type        = string
  default     = "ipv4"
}

variable "transit_vif_mtu" {
  description = "MTU size for the transit virtual interface (1500 or 8500)"
  type        = number
  default     = 1500
}

#==============================================================================
# TAGS
#==============================================================================

variable "tags" {
  description = "Map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}
