#==============================================================================
# COMMON VARIABLES
#==============================================================================

variable "aws_region" {
  description = "AWS region for the example provider"
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "Tags to apply to supported resources"
  type        = map(string)
  default     = {}
}

#==============================================================================
# ALB VARIABLES
#==============================================================================

variable "alb_name" {
  description = "Value for the name input of the alb module"
  type        = any
}

variable "alb_vpc_id" {
  description = "Value for the vpc_id input of the alb module"
  type        = any
}

variable "alb_subnets" {
  description = "Value for the subnets input of the alb module"
  type        = any
}

#==============================================================================
# API GATEWAY VARIABLES
#==============================================================================

variable "api_gateway_name" {
  description = "Value for the name input of the api-gateway module"
  type        = any
}

#==============================================================================
# CLOUDFRONT VARIABLES
#==============================================================================

variable "cloudfront_origins" {
  description = "Value for the origins input of the cloudfront module"
  type        = any
}

variable "cloudfront_default_cache_behavior" {
  description = "Value for the default_cache_behavior input of the cloudfront module"
  type        = any
}

#==============================================================================
# DIRECT CONNECT VARIABLES
#==============================================================================

variable "direct_connect_name" {
  description = "Value for the name input of the direct-connect module"
  type        = any
}

#==============================================================================
# ELASTIC IP VARIABLES
#==============================================================================

variable "elastic_ip_name" {
  description = "Value for the name input of the elastic-ip module"
  type        = any
}

#==============================================================================
# GLOBAL ACCELERATOR VARIABLES
#==============================================================================

variable "global_accelerator_name" {
  description = "Value for the name input of the global-accelerator module"
  type        = any
}

#==============================================================================
# NETWORK FIREWALL VARIABLES
#==============================================================================

variable "network_firewall_name" {
  description = "Value for the name input of the network-firewall module"
  type        = any
}

variable "network_firewall_vpc_id" {
  description = "Value for the vpc_id input of the network-firewall module"
  type        = any
}

variable "network_firewall_subnet_mapping" {
  description = "Value for the subnet_mapping input of the network-firewall module"
  type        = any
}

#==============================================================================
# NLB VARIABLES
#==============================================================================

variable "nlb_name" {
  description = "Value for the name input of the nlb module"
  type        = any
}

#==============================================================================
# PRIVATELINK VARIABLES
#==============================================================================

variable "privatelink_vpc_id" {
  description = "Value for the vpc_id input of the privatelink module"
  type        = any
}

#==============================================================================
# ROUTE53 VARIABLES
#==============================================================================

variable "route53_zone_name" {
  description = "Value for the zone_name input of the route53 module"
  type        = any
}

#==============================================================================
# SECURITY GROUP VARIABLES
#==============================================================================

variable "security_group_name" {
  description = "Value for the name input of the security-group module"
  type        = any
}

variable "security_group_vpc_id" {
  description = "Value for the vpc_id input of the security-group module"
  type        = any
}

#==============================================================================
# SUBNET VARIABLES
#==============================================================================

variable "subnet_name" {
  description = "Value for the name input of the subnet module"
  type        = any
}

variable "subnet_vpc_id" {
  description = "Value for the vpc_id input of the subnet module"
  type        = any
}

#==============================================================================
# TRANSIT GATEWAY VARIABLES
#==============================================================================

variable "transit_gateway_name" {
  description = "Value for the name input of the transit-gateway module"
  type        = any
}

#==============================================================================
# VPC VARIABLES
#==============================================================================

variable "vpc_name" {
  description = "Value for the name input of the vpc module"
  type        = any
}

variable "vpc_cidr_block" {
  description = "Value for the cidr_block input of the vpc module"
  type        = any
}

#==============================================================================
# VPC PEERING VARIABLES
#==============================================================================

variable "vpc_peering_name" {
  description = "Value for the name input of the vpc-peering module"
  type        = any
}

variable "vpc_peering_requester_vpc_id" {
  description = "Value for the requester_vpc_id input of the vpc-peering module"
  type        = any
}

variable "vpc_peering_accepter_vpc_id" {
  description = "Value for the accepter_vpc_id input of the vpc-peering module"
  type        = any
}

#==============================================================================
# VPN VARIABLES
#==============================================================================

variable "vpn_name" {
  description = "Value for the name input of the vpn module"
  type        = any
}

variable "vpn_customer_gateway_bgp_asn" {
  description = "Value for the customer_gateway_bgp_asn input of the vpn module"
  type        = any
}

variable "vpn_customer_gateway_ip_address" {
  description = "Value for the customer_gateway_ip_address input of the vpn module"
  type        = any
}
