#==============================================================================
# GENERAL
#==============================================================================

variable "name" {
  type        = string
  description = "Name of the Auto Scaling Group"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Map of tags to apply to all resources"
}

#==============================================================================
# CAPACITY
#==============================================================================

variable "min_size" {
  type        = number
  description = "Minimum number of instances in the ASG"
}

variable "max_size" {
  type        = number
  description = "Maximum number of instances in the ASG"
}

variable "desired_capacity" {
  type        = number
  description = "Desired number of instances in the ASG"
}

variable "wait_for_capacity_timeout" {
  type        = string
  default     = "10m"
  description = "Maximum duration to wait for ASG instances to become healthy"
}

variable "capacity_rebalance" {
  type        = bool
  default     = false
  description = "Whether capacity rebalance is enabled"
}

variable "protect_from_scale_in" {
  type        = bool
  default     = false
  description = "Whether newly launched instances are protected from scale in"
}

variable "max_instance_lifetime" {
  type        = number
  default     = 0
  description = "Maximum amount of time in seconds that an instance can be in service. 0 to disable"
}

variable "default_cooldown" {
  type        = number
  default     = 300
  description = "Time in seconds after a scaling activity completes before another can begin"
}

#==============================================================================
# NETWORK AND LAUNCH TEMPLATE
#==============================================================================

variable "vpc_zone_identifier" {
  type        = list(string)
  description = "List of subnet IDs to launch instances in"
}

variable "launch_template_id" {
  type        = string
  description = "ID of the launch template to use"
}

variable "launch_template_version" {
  type        = string
  default     = "$Default"
  description = "Version of the launch template to use"
}

variable "target_group_arns" {
  type        = list(string)
  default     = []
  description = "List of target group ARNs to associate with the ASG"
}

#==============================================================================
# HEALTH CHECK
#==============================================================================

variable "health_check_type" {
  type        = string
  default     = "EC2"
  description = "Type of health check to perform. Valid values: EC2, ELB"

  validation {
    condition     = contains(["EC2", "ELB"], var.health_check_type)
    error_message = "health_check_type must be either EC2 or ELB"
  }
}

variable "health_check_grace_period" {
  type        = number
  default     = 300
  description = "Time in seconds after instance launch before health checks begin"
}

#==============================================================================
# LIFECYCLE
#==============================================================================

variable "force_delete" {
  type        = bool
  default     = false
  description = "Whether to force delete the ASG without waiting for instances to terminate"
}

variable "termination_policies" {
  type        = list(string)
  default     = ["Default"]
  description = "List of policies to decide how instances are terminated"
}

variable "suspended_processes" {
  type        = list(string)
  default     = []
  description = "List of processes to suspend for the ASG"
}

variable "enabled_metrics" {
  type        = list(string)
  default     = []
  description = "List of metrics to collect for the ASG"
}

#==============================================================================
# INSTANCE REFRESH
#==============================================================================

variable "instance_refresh" {
  type = object({
    strategy = string
    preferences = optional(object({
      min_healthy_percentage = optional(number, 90)
      instance_warmup        = optional(number, 300)
      checkpoint_delay       = optional(number, 3600)
      checkpoint_percentages = optional(list(number), [])
    }))
  })
  default     = null
  description = "Instance refresh configuration"
}

#==============================================================================
# WARM POOL
#==============================================================================

variable "warm_pool" {
  type = object({
    pool_state                  = optional(string, "Stopped")
    min_size                    = optional(number, 0)
    max_group_prepared_capacity = optional(number, -1)
    reuse_on_scale_in           = optional(bool, false)
  })
  default     = null
  description = "Warm pool configuration"
}

#==============================================================================
# SCALING POLICIES
#==============================================================================

variable "scaling_policies" {
  type = list(object({
    name                      = string
    policy_type               = string
    estimated_instance_warmup = optional(number)
    cooldown                  = optional(number)
    target_tracking_configuration = optional(object({
      predefined_metric_type = string
      target_value           = number
      disable_scale_in       = optional(bool, false)
    }))
    step_adjustment = optional(list(object({
      scaling_adjustment          = number
      metric_interval_lower_bound = optional(number)
      metric_interval_upper_bound = optional(number)
    })))
  }))
  default     = []
  description = "List of scaling policy configurations"
}

#==============================================================================
# SCHEDULED ACTIONS
#==============================================================================

variable "scheduled_actions" {
  type = list(object({
    name             = string
    min_size         = optional(number)
    max_size         = optional(number)
    desired_capacity = optional(number)
    recurrence       = optional(string)
    start_time       = optional(string)
    end_time         = optional(string)
  }))
  default     = []
  description = "List of scheduled action configurations"
}
