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
# BILLING CONDUCTOR VARIABLES
#==============================================================================

variable "billing_conductor_resources" {
  description = "Billing Conductor Cloud Control resources to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# BUDGETS VARIABLES
#==============================================================================

variable "budgets" {
  description = "AWS Budgets to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# COST ANOMALY DETECTION VARIABLES
#==============================================================================

variable "cost_anomaly_monitors" {
  description = "Cost anomaly monitors to create"
  type        = list(any)
  default     = []
}

variable "cost_anomaly_subscriptions" {
  description = "Cost anomaly subscriptions to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# SAVINGS PLANS VARIABLES
#==============================================================================

variable "savings_plans" {
  description = "Savings Plans purchases to create"
  type        = list(any)
  default     = []
}
