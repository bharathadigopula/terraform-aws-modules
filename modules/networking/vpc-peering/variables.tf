#==============================================================================
# GENERAL
#==============================================================================

variable "name" {
  type        = string
  description = "Name for the VPC peering connection"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}

#==============================================================================
# VPC PEERING CONNECTION
#==============================================================================

variable "requester_vpc_id" {
  type        = string
  description = "ID of the requester VPC"
}

variable "accepter_vpc_id" {
  type        = string
  description = "ID of the accepter VPC"
}

variable "peer_owner_id" {
  type        = string
  description = "AWS account ID of the accepter VPC owner"
  default     = null
}

variable "peer_region" {
  type        = string
  description = "Region of the accepter VPC"
  default     = null
}

variable "auto_accept" {
  type        = bool
  description = "Whether to auto-accept the peering connection"
  default     = false
}

#==============================================================================
# DNS RESOLUTION
#==============================================================================

variable "allow_requester_dns_resolution" {
  type        = bool
  description = "Allow the requester VPC to resolve public DNS hostnames to private IP addresses of the accepter VPC"
  default     = false
}

variable "allow_accepter_dns_resolution" {
  type        = bool
  description = "Allow the accepter VPC to resolve public DNS hostnames to private IP addresses of the requester VPC"
  default     = false
}

#==============================================================================
# ROUTING
#==============================================================================

variable "requester_route_table_ids" {
  type        = list(string)
  description = "List of route table IDs in the requester VPC to add routes to the accepter VPC CIDR"
  default     = []
}

variable "accepter_route_table_ids" {
  type        = list(string)
  description = "List of route table IDs in the accepter VPC to add routes to the requester VPC CIDR"
  default     = []
}

variable "requester_vpc_cidr" {
  type        = string
  description = "CIDR block of the requester VPC"
  default     = null
}

variable "accepter_vpc_cidr" {
  type        = string
  description = "CIDR block of the accepter VPC"
  default     = null
}
