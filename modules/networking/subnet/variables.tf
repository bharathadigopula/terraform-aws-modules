#==============================================================================
# SUBNET CONFIGURATION VARIABLES
#==============================================================================

variable "name" {
  description = "Name prefix for all subnet resources"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where subnets will be created"
  type        = string
}

variable "igw_id" {
  description = "Internet Gateway ID for public route table"
  type        = string
  default     = ""
}

#==============================================================================
# PUBLIC SUBNET VARIABLES
#==============================================================================

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = []
}

variable "public_subnet_names" {
  description = "Custom names for public subnets (must match length of public_subnets)"
  type        = list(string)
  default     = []
}

variable "public_subnet_availability_zones" {
  description = "List of availability zones for public subnets"
  type        = list(string)
  default     = []
}

variable "map_public_ip_on_launch" {
  description = "Auto-assign public IP addresses to instances in public subnets"
  type        = bool
  default     = true
}

#==============================================================================
# PRIVATE SUBNET VARIABLES
#==============================================================================

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default     = []
}

variable "private_subnet_names" {
  description = "Custom names for private subnets (must match length of private_subnets)"
  type        = list(string)
  default     = []
}

variable "private_subnet_availability_zones" {
  description = "List of availability zones for private subnets"
  type        = list(string)
  default     = []
}

#==============================================================================
# DATABASE SUBNET VARIABLES
#==============================================================================

variable "database_subnets" {
  description = "List of database subnet CIDR blocks"
  type        = list(string)
  default     = []
}

variable "database_subnet_names" {
  description = "Custom names for database subnets (must match length of database_subnets)"
  type        = list(string)
  default     = []
}

variable "database_subnet_availability_zones" {
  description = "List of availability zones for database subnets"
  type        = list(string)
  default     = []
}

variable "create_database_subnet_group" {
  description = "Create a database subnet group from database subnets"
  type        = bool
  default     = true
}

variable "database_subnet_group_name" {
  description = "Name of the database subnet group"
  type        = string
  default     = ""
}

#==============================================================================
# NAT GATEWAY VARIABLES
#==============================================================================

variable "enable_nat_gateway" {
  description = "Provision NAT Gateways for private subnets"
  type        = bool
  default     = false
}

variable "single_nat_gateway" {
  description = "Use a single NAT Gateway for all private subnets (cost saving for non-prod)"
  type        = bool
  default     = false
}

variable "one_nat_gateway_per_az" {
  description = "Create one NAT Gateway per availability zone (high availability for prod)"
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

variable "public_subnet_tags" {
  description = "Additional tags for public subnets"
  type        = map(string)
  default     = {}
}

variable "private_subnet_tags" {
  description = "Additional tags for private subnets"
  type        = map(string)
  default     = {}
}

variable "database_subnet_tags" {
  description = "Additional tags for database subnets"
  type        = map(string)
  default     = {}
}
