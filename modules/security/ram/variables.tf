#==============================================================================
# RAM VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the RAM resource share"
  type        = string
}

variable "allow_external_principals" {
  description = "Whether to allow external principals (accounts outside the org)"
  type        = bool
  default     = false
}

variable "permission_arns" {
  description = "List of RAM permission ARNs to associate"
  type        = list(string)
  default     = []
}

variable "resource_arns" {
  description = "List of resource ARNs to share"
  type        = list(string)
  default     = []
}

variable "principal_arns" {
  description = "List of principal ARNs to share with (account IDs, org ARN, OU ARN)"
  type        = list(string)
  default     = []
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
