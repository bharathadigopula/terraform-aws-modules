#==============================================================================
# SECURITY GROUP IDENTITY
#==============================================================================

variable "name" {
  type        = string
  description = "Name of the security group"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the security group will be created"
}

variable "description" {
  type        = string
  default     = "Managed by Terraform"
  description = "Description for the security group"
}

#==============================================================================
# FULL INGRESS RULES
#==============================================================================

variable "ingress_rules" {
  type = list(object({
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = optional(list(string), [])
    ipv6_cidr_blocks         = optional(list(string), [])
    source_security_group_id = optional(string, null)
    self                     = optional(bool, false)
    description              = optional(string, "")
  }))
  default     = []
  description = "List of ingress rule objects with full control over each field"
}

#==============================================================================
# FULL EGRESS RULES
#==============================================================================

variable "egress_rules" {
  type = list(object({
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = optional(list(string), [])
    ipv6_cidr_blocks         = optional(list(string), [])
    source_security_group_id = optional(string, null)
    self                     = optional(bool, false)
    description              = optional(string, "")
  }))
  default     = []
  description = "List of egress rule objects with full control over each field"
}

#==============================================================================
# SIMPLIFIED INGRESS WITH CIDR BLOCKS
#==============================================================================

variable "ingress_with_cidr_blocks" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = optional(string, "")
  }))
  default     = []
  description = "Simplified ingress rules using only CIDR blocks"
}

#==============================================================================
# SIMPLIFIED EGRESS WITH CIDR BLOCKS
#==============================================================================

variable "egress_with_cidr_blocks" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = optional(string, "")
  }))
  default     = []
  description = "Simplified egress rules using only CIDR blocks"
}

#==============================================================================
# TAGS
#==============================================================================

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Map of tags to apply to the security group"
}
