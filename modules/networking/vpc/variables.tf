#==============================================================================
# VPC CONFIGURATION VARIABLES
#==============================================================================

variable "name" {
  description = "Name prefix for all VPC resources"
  type        = string
}

variable "cidr_block" {
  description = "The IPv4 CIDR block for the VPC"
  type        = string
}

variable "secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks to associate with the VPC"
  type        = list(string)
  default     = []
}

variable "instance_tenancy" {
  description = "Tenancy option for instances launched into the VPC (default, dedicated, host)"
  type        = string
  default     = "default"
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "assign_generated_ipv6_cidr_block" {
  description = "Request an Amazon-provided IPv6 CIDR block with a /56 prefix"
  type        = bool
  default     = false
}

#==============================================================================
# DHCP OPTIONS VARIABLES
#==============================================================================

variable "enable_dhcp_options" {
  description = "Create a new DHCP options set and associate with the VPC"
  type        = bool
  default     = false
}

variable "dhcp_options_domain_name" {
  description = "Specifies DNS name for DHCP options set"
  type        = string
  default     = ""
}

variable "dhcp_options_domain_name_servers" {
  description = "List of DNS server addresses for DHCP options set"
  type        = list(string)
  default     = ["AmazonProvidedDNS"]
}

variable "dhcp_options_ntp_servers" {
  description = "List of NTP servers for DHCP options set"
  type        = list(string)
  default     = []
}

variable "dhcp_options_netbios_name_servers" {
  description = "List of NetBIOS name servers for DHCP options set"
  type        = list(string)
  default     = []
}

variable "dhcp_options_netbios_node_type" {
  description = "NetBIOS node type (1, 2, 4, or 8) for DHCP options set"
  type        = string
  default     = ""
}

#==============================================================================
# INTERNET GATEWAY VARIABLES
#==============================================================================

variable "create_igw" {
  description = "Create an Internet Gateway for the VPC"
  type        = bool
  default     = true
}

#==============================================================================
# VPC FLOW LOG VARIABLES
#==============================================================================

variable "enable_flow_log" {
  description = "Enable VPC flow logs"
  type        = bool
  default     = false
}

variable "flow_log_destination_type" {
  description = "Type of flow log destination (cloud-watch-logs or s3)"
  type        = string
  default     = "cloud-watch-logs"
}

variable "flow_log_destination_arn" {
  description = "ARN of the destination for VPC flow logs (CloudWatch log group or S3 bucket)"
  type        = string
  default     = ""
}

variable "flow_log_traffic_type" {
  description = "Type of traffic to capture (ACCEPT, REJECT, ALL)"
  type        = string
  default     = "ALL"
}

variable "flow_log_max_aggregation_interval" {
  description = "Maximum interval of time (seconds) for flow log aggregation (60 or 600)"
  type        = number
  default     = 600
}

variable "flow_log_iam_role_arn" {
  description = "IAM role ARN for publishing flow logs to CloudWatch"
  type        = string
  default     = ""
}

variable "create_flow_log_cloudwatch_log_group" {
  description = "Create a CloudWatch log group for VPC flow logs"
  type        = bool
  default     = false
}

variable "flow_log_cloudwatch_log_group_retention" {
  description = "Number of days to retain flow log events in CloudWatch"
  type        = number
  default     = 30
}

variable "flow_log_cloudwatch_log_group_kms_key_id" {
  description = "KMS key ID for encrypting the flow log CloudWatch log group"
  type        = string
  default     = null
}

#==============================================================================
# DEFAULT SECURITY GROUP VARIABLES
#==============================================================================

variable "manage_default_security_group" {
  description = "Manage the default security group of the VPC"
  type        = bool
  default     = true
}

variable "default_security_group_ingress" {
  description = "Ingress rules for the default security group"
  type        = list(map(string))
  default     = []
}

variable "default_security_group_egress" {
  description = "Egress rules for the default security group"
  type        = list(map(string))
  default     = []
}

#==============================================================================
# DEFAULT NETWORK ACL VARIABLES
#==============================================================================

variable "manage_default_network_acl" {
  description = "Manage the default network ACL of the VPC"
  type        = bool
  default     = true
}

variable "default_network_acl_ingress" {
  description = "Ingress rules for the default network ACL"
  type = list(object({
    rule_no    = number
    action     = string
    from_port  = number
    to_port    = number
    protocol   = string
    cidr_block = string
  }))
  default = [
    {
      rule_no    = 100
      action     = "allow"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
    }
  ]
}

variable "default_network_acl_egress" {
  description = "Egress rules for the default network ACL"
  type = list(object({
    rule_no    = number
    action     = string
    from_port  = number
    to_port    = number
    protocol   = string
    cidr_block = string
  }))
  default = [
    {
      rule_no    = 100
      action     = "allow"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
    }
  ]
}

#==============================================================================
# TAGGING VARIABLES
#==============================================================================

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_tags" {
  description = "Additional tags for the VPC resource only"
  type        = map(string)
  default     = {}
}

variable "igw_tags" {
  description = "Additional tags for the Internet Gateway"
  type        = map(string)
  default     = {}
}
