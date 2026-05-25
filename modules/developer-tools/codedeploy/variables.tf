#==============================================================================
# CODEDEPLOY APPLICATION VARIABLES
#==============================================================================

variable "applications" {
  description = "List of CodeDeploy applications to create"
  type = list(object({
    name             = string
    compute_platform = optional(string)
    tags             = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# CODEDEPLOY DEPLOYMENT GROUP VARIABLES
#==============================================================================

variable "deployment_groups" {
  description = "List of CodeDeploy deployment groups to create"
  type = list(object({
    name                        = string
    app_name                    = string
    service_role_arn            = string
    deployment_config_name      = optional(string)
    autoscaling_groups          = optional(set(string))
    outdated_instances_strategy = optional(string)
    termination_hook_enabled    = optional(bool)
    deployment_style = optional(object({
      deployment_option = optional(string)
      deployment_type   = optional(string)
    }))
    alarm_configuration = optional(object({
      alarms                    = optional(set(string))
      enabled                   = optional(bool)
      ignore_poll_alarm_failure = optional(bool)
    }))
    auto_rollback_configuration = optional(object({
      enabled = optional(bool)
      events  = optional(set(string))
    }))
    ec2_tag_filters = optional(list(object({
      key   = optional(string)
      type  = optional(string)
      value = optional(string)
    })), [])
    ecs_service = optional(object({
      cluster_name = string
      service_name = string
    }))
    trigger_configurations = optional(list(object({
      trigger_name       = string
      trigger_target_arn = string
      trigger_events     = set(string)
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
