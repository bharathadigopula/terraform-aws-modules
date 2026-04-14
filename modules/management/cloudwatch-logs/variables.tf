#==============================================================================
# LOG GROUP VARIABLES
#==============================================================================
variable "log_groups" {
  description = "List of CloudWatch Log Groups to create"
  type = list(object({
    name              = string
    retention_in_days = optional(number, 365)
    kms_key_id        = optional(string)
    log_group_class   = optional(string, "STANDARD")
    skip_destroy      = optional(bool, false)
    tags              = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# METRIC FILTER VARIABLES
#==============================================================================
variable "metric_filters" {
  description = "List of log metric filters"
  type = list(object({
    name             = string
    log_group_name   = string
    pattern          = string
    metric_name      = string
    metric_namespace = string
    metric_value     = optional(string, "1")
    default_value    = optional(string)
  }))
  default = []
}

#==============================================================================
# SUBSCRIPTION FILTER VARIABLES
#==============================================================================
variable "subscription_filters" {
  description = "List of log subscription filters"
  type = list(object({
    name            = string
    log_group_name  = string
    filter_pattern  = string
    destination_arn = string
    role_arn        = optional(string)
    distribution    = optional(string, "ByLogStream")
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
