#==============================================================================
# BUDGET VARIABLES
#==============================================================================

variable "budgets" {
  description = "List of AWS Budgets to create"
  type = list(object({
    name              = optional(string)
    name_prefix       = optional(string)
    budget_type       = string
    limit_amount      = optional(string)
    limit_unit        = optional(string)
    time_unit         = string
    time_period_start = optional(string)
    time_period_end   = optional(string)
    account_id        = optional(string)
    billing_view_arn  = optional(string)
    cost_filters = optional(list(object({
      name   = string
      values = list(string)
    })), [])
    cost_types = optional(object({
      include_credit             = optional(bool)
      include_discount           = optional(bool)
      include_other_subscription = optional(bool)
      include_recurring          = optional(bool)
      include_refund             = optional(bool)
      include_subscription       = optional(bool)
      include_support            = optional(bool)
      include_tax                = optional(bool)
      include_upfront            = optional(bool)
      use_amortized              = optional(bool)
      use_blended                = optional(bool)
    }))
    planned_limits = optional(list(object({
      amount     = string
      start_time = string
      unit       = string
    })), [])
    notifications = optional(list(object({
      comparison_operator        = string
      notification_type          = string
      threshold                  = number
      threshold_type             = string
      subscriber_email_addresses = optional(set(string))
      subscriber_sns_topic_arns  = optional(set(string))
    })), [])
    tags = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================

variable "tags" {
  description = "Tags to apply to all supported resources"
  type        = map(string)
  default     = {}
}
