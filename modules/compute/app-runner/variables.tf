#==============================================================================
# APP RUNNER SERVICE VARIABLES
#==============================================================================

variable "service_name" {
  type        = string
  description = "Name of the App Runner service"
}

variable "source_type" {
  type        = string
  description = "Source type for the service (image or code)"

  validation {
    condition     = contains(["image", "code"], var.source_type)
    error_message = "source_type must be either image or code"
  }
}

#==============================================================================
# IMAGE REPOSITORY CONFIGURATION
#==============================================================================

variable "image_repository" {
  type = object({
    image_identifier      = string
    image_repository_type = string
    image_configuration = optional(object({
      port                          = optional(string)
      runtime_environment_variables = optional(map(string))
      start_command                 = optional(string)
    }))
  })
  description = "Image repository configuration when source_type is image"
  default     = null
}

#==============================================================================
# CODE REPOSITORY CONFIGURATION
#==============================================================================

variable "code_repository" {
  type = object({
    repository_url = string
    source_code_version = object({
      type  = string
      value = string
    })
    code_configuration = object({
      configuration_source          = string
      build_command                 = optional(string)
      runtime                       = optional(string)
      port                          = optional(string)
      start_command                 = optional(string)
      runtime_environment_variables = optional(map(string))
    })
  })
  description = "Code repository configuration when source_type is code"
  default     = null
}

#==============================================================================
# AUTO SCALING CONFIGURATION
#==============================================================================

variable "auto_scaling_configuration" {
  type = object({
    max_concurrency = optional(number, 100)
    max_size        = optional(number, 25)
    min_size        = optional(number, 1)
  })
  description = "Auto scaling configuration for the App Runner service"
  default     = null
}

#==============================================================================
# INSTANCE CONFIGURATION
#==============================================================================

variable "instance_configuration" {
  type = object({
    cpu               = optional(string, "1024")
    memory            = optional(string, "2048")
    instance_role_arn = optional(string)
  })
  description = "Instance configuration for the App Runner service"
  default     = null
}

#==============================================================================
# HEALTH CHECK CONFIGURATION
#==============================================================================

variable "health_check_configuration" {
  type = object({
    protocol            = optional(string, "TCP")
    path                = optional(string)
    interval            = optional(number, 5)
    timeout             = optional(number, 2)
    healthy_threshold   = optional(number, 1)
    unhealthy_threshold = optional(number, 5)
  })
  description = "Health check configuration for the App Runner service"
  default     = null
}

#==============================================================================
# SERVICE ACCESS AND NETWORKING
#==============================================================================

variable "access_role_arn" {
  type        = string
  description = "ARN of the IAM role that grants App Runner access to pull the image or code"
  default     = null
}

variable "auto_deployments_enabled" {
  type        = bool
  description = "Whether automatic deployments are enabled"
  default     = false
}

variable "vpc_connector_arn" {
  type        = string
  description = "ARN of the VPC connector for the service"
  default     = null
}

#==============================================================================
# ENCRYPTION AND OBSERVABILITY
#==============================================================================

variable "encryption_kms_key" {
  type        = string
  description = "ARN of the KMS key used for encryption"
  default     = null
}

variable "observability_enabled" {
  type        = bool
  description = "Whether observability is enabled for the service"
  default     = false
}

#==============================================================================
# TAGS
#==============================================================================

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}
