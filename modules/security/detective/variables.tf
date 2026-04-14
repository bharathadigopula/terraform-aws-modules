#==============================================================================
# DETECTIVE VARIABLES
#==============================================================================
variable "member_accounts" {
  description = "List of member accounts to add to the Detective graph"
  type = list(object({
    account_id                 = string
    email                      = string
    disable_email_notification = optional(bool, false)
    message                    = optional(string)
  }))
  default = []
}

#==============================================================================
# ORGANIZATION VARIABLES
#==============================================================================
variable "admin_account_id" {
  description = "AWS account ID to designate as Detective delegated admin"
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
