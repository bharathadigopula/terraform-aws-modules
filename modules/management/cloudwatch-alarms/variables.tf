#==============================================================================
# ALARM VARIABLES
#==============================================================================
variable "alarms" {
  description = "List of CloudWatch metric alarms to create"
  type = list(object({
    alarm_name          = string
    alarm_description   = optional(string, "Managed by Terraform")
    comparison_operator = string
    evaluation_periods  = number
    metric_name         = optional(string)
    namespace           = optional(string)
    period              = optional(number)
    statistic           = optional(string)
    threshold           = optional(number)
    threshold_metric_id = optional(string)

    datapoints_to_alarm = optional(number)
    treat_missing_data  = optional(string, "missing")
    unit                = optional(string)

    dimensions = optional(map(string), {})

    alarm_actions             = optional(list(string), [])
    ok_actions                = optional(list(string), [])
    insufficient_data_actions = optional(list(string), [])

    actions_enabled = optional(bool, true)

    metric_queries = optional(list(object({
      id          = string
      expression  = optional(string)
      label       = optional(string)
      return_data = optional(bool)
      metric = optional(object({
        metric_name = string
        namespace   = string
        period      = number
        stat        = string
        unit        = optional(string)
        dimensions  = optional(map(string), {})
      }))
    })), [])

    tags = optional(map(string), {})
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
