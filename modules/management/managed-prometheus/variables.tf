#==============================================================================
# WORKSPACE VARIABLES
#==============================================================================
variable "alias" {
  description = "Alias for the Prometheus workspace"
  type        = string
  default     = null
}

variable "kms_key_arn" {
  description = "KMS key ARN for workspace encryption"
  type        = string
  default     = null
}

variable "log_group_arn" {
  description = "CloudWatch Log Group ARN for workspace logging"
  type        = string
  default     = null
}

#==============================================================================
# ALERT MANAGER VARIABLES
#==============================================================================
variable "alert_manager_definition" {
  description = "Alert manager definition YAML"
  type        = string
  default     = null
}

#==============================================================================
# RULE GROUP VARIABLES
#==============================================================================
variable "rule_group_namespaces" {
  description = "List of rule group namespaces"
  type = list(object({
    name = string
    data = string
  }))
  default = []
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
