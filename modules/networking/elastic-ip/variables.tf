#==============================================================================
# ELASTIC IP VARIABLES
#==============================================================================

variable "name" {
  description = "Name prefix for all Elastic IP resources"
  type        = string
}

variable "eip_count" {
  description = "Number of Elastic IPs to allocate"
  type        = number
  default     = 1
}

variable "domain" {
  description = "Indicates if this EIP is for use in VPC"
  type        = string
  default     = "vpc"
}

variable "public_ipv4_pool" {
  description = "EC2 IPv4 address pool identifier for a customer-owned pool"
  type        = string
  default     = null
}

#==============================================================================
# ASSOCIATION VARIABLES
#==============================================================================

variable "instance_ids" {
  description = "List of EC2 instance IDs to associate with EIPs (length must match eip_count)"
  type        = list(string)
  default     = []
}

variable "network_interface_ids" {
  description = "List of ENI IDs to associate with EIPs (length must match eip_count)"
  type        = list(string)
  default     = []
}

variable "private_ips" {
  description = "List of private IPs to associate with EIPs on the ENI"
  type        = list(string)
  default     = []
}

variable "allow_reassociation" {
  description = "Allow a reassociation if the EIP is already associated"
  type        = bool
  default     = false
}

#==============================================================================
# TAGGING VARIABLES
#==============================================================================

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}
