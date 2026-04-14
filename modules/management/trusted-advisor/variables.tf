#==============================================================================
# TRUSTED ADVISOR VARIABLES
#==============================================================================
variable "enable_organization_access" {
  description = "Whether to enable Trusted Advisor organization access"
  type        = bool
  default     = false
}
