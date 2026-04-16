#==============================================================================
# SWF DOMAIN VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the SWF domain"
  type        = string
}

variable "description" {
  description = "Description of the SWF domain"
  type        = string
  default     = "Managed by Terraform"
}

variable "workflow_execution_retention_period_in_days" {
  description = "Maximum workflow execution retention period in days"
  type        = string
  default     = "90"
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
