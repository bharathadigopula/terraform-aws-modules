#==============================================================================
# COMPUTE ENVIRONMENT VARIABLES
#==============================================================================

variable "name" {
  type        = string
  description = "Name of the Batch compute environment"
}

variable "compute_environment_type" {
  type        = string
  description = "Type of the compute environment"
  default     = "MANAGED"

  validation {
    condition     = contains(["MANAGED", "UNMANAGED"], var.compute_environment_type)
    error_message = "Compute environment type must be either MANAGED or UNMANAGED."
  }
}

variable "state" {
  type        = string
  description = "State of the compute environment"
  default     = "ENABLED"
}

variable "service_role" {
  type        = string
  description = "IAM service role ARN for the Batch compute environment"
}

variable "compute_resources" {
  type = object({
    type                = string
    min_vcpus           = number
    max_vcpus           = number
    desired_vcpus       = optional(number)
    instance_types      = list(string)
    subnets             = list(string)
    security_group_ids  = list(string)
    instance_role       = string
    allocation_strategy = optional(string)
    bid_percentage      = optional(number)
    launch_template_id  = optional(string)
    ec2_key_pair        = optional(string)
    tags                = optional(map(string), {})
  })
  description = "Compute resources configuration for the Batch compute environment"
  default     = null
}

#==============================================================================
# JOB QUEUE VARIABLES
#==============================================================================

variable "job_queue_name" {
  type        = string
  description = "Name of the Batch job queue"
}

variable "job_queue_priority" {
  type        = number
  description = "Priority of the job queue"
  default     = 1
}

variable "job_queue_state" {
  type        = string
  description = "State of the job queue"
  default     = "ENABLED"
}

#==============================================================================
# JOB DEFINITION VARIABLES
#==============================================================================

variable "job_definitions" {
  type = list(object({
    name                      = string
    type                      = string
    container_properties_json = string
    timeout_seconds           = optional(number)
    retry_attempts            = optional(number, 1)
  }))
  description = "List of Batch job definitions to create"
  default     = []
}

#==============================================================================
# TAGS
#==============================================================================

variable "tags" {
  type        = map(string)
  description = "Map of tags to apply to all resources"
  default     = {}
}
