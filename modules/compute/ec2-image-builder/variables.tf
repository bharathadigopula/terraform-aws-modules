#==============================================================================
# GENERAL
#==============================================================================

variable "name" {
  type        = string
  description = "Name prefix for all Image Builder resources"
}

variable "description" {
  type        = string
  description = "Description for the image recipe"
  default     = ""
}

variable "platform" {
  type        = string
  description = "Platform of the image recipe"

  validation {
    condition     = contains(["Linux", "Windows"], var.platform)
    error_message = "Platform must be either Linux or Windows."
  }
}

variable "parent_image" {
  type        = string
  description = "ARN or AMI ID of the base image"
}

variable "recipe_version" {
  type        = string
  description = "Semantic version of the image recipe"
}

#==============================================================================
# INFRASTRUCTURE CONFIGURATION
#==============================================================================

variable "instance_types" {
  type        = list(string)
  description = "List of EC2 instance types for the build"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the build instance"
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs for the build instance"
}

variable "iam_instance_profile_name" {
  type        = string
  description = "IAM instance profile name for the build instance"
}

variable "key_pair" {
  type        = string
  description = "Key pair name for the build instance"
  default     = null
}

variable "terminate_instance_on_failure" {
  type        = bool
  description = "Whether to terminate the instance on failure"
  default     = true
}

#==============================================================================
# COMPONENTS
#==============================================================================

variable "components" {
  type = list(object({
    component_arn = string
  }))
  description = "List of component ARNs to include in the image recipe"
}

#==============================================================================
# DISTRIBUTION
#==============================================================================

variable "distribution_regions" {
  type = list(object({
    region   = string
    ami_name = string
  }))
  description = "List of distribution regions and AMI names"
}

#==============================================================================
# SCHEDULE
#==============================================================================

variable "schedule" {
  type = object({
    schedule_expression                = string
    pipeline_execution_start_condition = optional(string, "EXPRESSION_MATCH_ONLY")
    timezone                           = optional(string, "UTC")
  })
  description = "Schedule configuration for the image pipeline"
  default     = null
}

#==============================================================================
# ENCRYPTION
#==============================================================================

variable "kms_key_id" {
  type        = string
  description = "KMS key ID for encrypting the image"
  default     = null
}

#==============================================================================
# TAGS
#==============================================================================

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}
