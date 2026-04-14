#==============================================================================
# DIRECTORY VARIABLES
#==============================================================================
variable "name" {
  description = "Fully qualified domain name for the directory"
  type        = string
}

variable "password" {
  description = "Password for the directory administrator"
  type        = string
  sensitive   = true
}

variable "type" {
  description = "Directory type (SimpleAD, MicrosoftAD)"
  type        = string
  default     = "MicrosoftAD"
}

variable "size" {
  description = "Size of the directory (Small or Large) for SimpleAD"
  type        = string
  default     = "Small"
}

variable "edition" {
  description = "Edition of Microsoft AD (Standard or Enterprise)"
  type        = string
  default     = "Standard"
}

variable "short_name" {
  description = "Short name (NetBIOS) of the directory"
  type        = string
  default     = null
}

variable "description" {
  description = "Description for the directory"
  type        = string
  default     = null
}

variable "alias" {
  description = "Alias for the directory"
  type        = string
  default     = null
}

variable "enable_sso" {
  description = "Whether to enable single sign-on"
  type        = bool
  default     = false
}

#==============================================================================
# VPC VARIABLES
#==============================================================================
variable "vpc_id" {
  description = "ID of the VPC for the directory"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the directory (exactly 2 required)"
  type        = list(string)
}

#==============================================================================
# CONDITIONAL FORWARDER VARIABLES
#==============================================================================
variable "conditional_forwarders" {
  description = "List of conditional forwarders"
  type = list(object({
    remote_domain_name = string
    dns_ips            = list(string)
  }))
  default = []
}

#==============================================================================
# LOGGING VARIABLES
#==============================================================================
variable "cloudwatch_log_group_name" {
  description = "CloudWatch Log Group name for directory logs"
  type        = string
  default     = null
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
