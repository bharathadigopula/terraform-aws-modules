#==============================================================================
# ECS SERVICE VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the ECS service"
  type        = string
}

variable "cluster_arn" {
  description = "ARN of the ECS cluster to run the service in"
  type        = string
}

variable "task_definition_arn" {
  description = "ARN of the task definition to use for the service"
  type        = string
}

variable "desired_count" {
  description = "Number of desired task instances to run"
  type        = number
  default     = 1
}

variable "launch_type" {
  description = "Launch type for the service - FARGATE or EC2"
  type        = string
  default     = "FARGATE"

  validation {
    condition     = contains(["FARGATE", "EC2"], var.launch_type)
    error_message = "launch_type must be either FARGATE or EC2."
  }
}

variable "platform_version" {
  description = "Platform version for Fargate tasks (use LATEST for newest)"
  type        = string
  default     = "LATEST"
}

variable "scheduling_strategy" {
  description = "Scheduling strategy - REPLICA or DAEMON"
  type        = string
  default     = "REPLICA"

  validation {
    condition     = contains(["REPLICA", "DAEMON"], var.scheduling_strategy)
    error_message = "scheduling_strategy must be either REPLICA or DAEMON."
  }
}

variable "deployment_minimum_healthy_percent" {
  description = "Lower limit on the number of running tasks as a percentage of desired count during deployment"
  type        = number
  default     = 100
}

variable "deployment_maximum_percent" {
  description = "Upper limit on the number of running tasks as a percentage of desired count during deployment"
  type        = number
  default     = 200
}

variable "health_check_grace_period_seconds" {
  description = "Seconds to ignore failing load balancer health checks on newly instantiated tasks"
  type        = number
  default     = null
}

variable "enable_execute_command" {
  description = "Whether to enable ECS Exec for the service"
  type        = bool
  default     = false
}

variable "force_new_deployment" {
  description = "Whether to force a new deployment of the service"
  type        = bool
  default     = false
}

variable "network_configuration" {
  description = "Network configuration for the service including subnets, security groups, and public IP assignment"
  type = object({
    subnets          = list(string)
    security_groups  = optional(list(string), [])
    assign_public_ip = optional(bool, false)
  })
  default = null
}

variable "load_balancer" {
  description = "List of load balancer target group configurations for the service"
  type = list(object({
    target_group_arn = string
    container_name   = string
    container_port   = number
  }))
  default = []
}

variable "service_registries" {
  description = "Service discovery registry configuration"
  type = object({
    registry_arn   = string
    container_name = optional(string, null)
    container_port = optional(number, null)
  })
  default = null
}

variable "deployment_circuit_breaker" {
  description = "Deployment circuit breaker configuration"
  type = object({
    enable   = bool
    rollback = bool
  })
  default = null
}

variable "ordered_placement_strategy" {
  description = "List of placement strategy rules for task placement"
  type = list(object({
    type  = string
    field = optional(string, null)
  }))
  default = []
}

variable "capacity_provider_strategy" {
  description = "List of capacity provider strategies for the service"
  type = list(object({
    capacity_provider = string
    weight            = optional(number, 0)
    base              = optional(number, 0)
  }))
  default = []
}

variable "propagate_tags" {
  description = "Whether to propagate tags from TASK_DEFINITION, SERVICE, or NONE"
  type        = string
  default     = null

  validation {
    condition     = var.propagate_tags == null || contains(["TASK_DEFINITION", "SERVICE", "NONE"], var.propagate_tags)
    error_message = "propagate_tags must be TASK_DEFINITION, SERVICE, or NONE."
  }
}

variable "enable_ecs_managed_tags" {
  description = "Whether to enable ECS managed tags for the tasks"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Map of tags to assign to the service"
  type        = map(string)
  default     = {}
}
