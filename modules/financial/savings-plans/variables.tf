#==============================================================================
# SAVINGS PLAN VARIABLES
#==============================================================================

variable "savings_plans" {
  description = "List of Savings Plans to purchase"
  type = list(object({
    name                     = string
    savings_plan_offering_id = string
    commitment               = string
    upfront_payment_amount   = optional(string)
    purchase_time            = optional(string)
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
    }))
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
