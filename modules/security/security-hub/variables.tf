#==============================================================================
# SECURITY HUB VARIABLES
#==============================================================================
variable "enable_default_standards" {
  description = "Whether to enable default security standards"
  type        = bool
  default     = true
}

variable "control_finding_generator" {
  description = "Control finding generator (SECURITY_CONTROL or STANDARD_CONTROL)"
  type        = string
  default     = "SECURITY_CONTROL"
}

variable "auto_enable_controls" {
  description = "Whether to auto-enable new controls in subscribed standards"
  type        = bool
  default     = true
}

variable "standards_arns" {
  description = "List of security standard ARNs to subscribe to"
  type        = list(string)
  default     = []
}

variable "product_arns" {
  description = "List of product ARNs to subscribe to"
  type        = list(string)
  default     = []
}

#==============================================================================
# ORGANIZATION VARIABLES
#==============================================================================
variable "admin_account_id" {
  description = "AWS account ID to designate as Security Hub delegated admin"
  type        = string
  default     = null
}
