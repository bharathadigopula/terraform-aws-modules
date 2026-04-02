#==============================================================================
# GENERAL
#==============================================================================

variable "name" {
  type        = string
  description = "Name of the launch template"
}

variable "description" {
  type        = string
  description = "Description of the launch template"
  default     = null
}

variable "image_id" {
  type        = string
  description = "AMI ID for the launch template"
  default     = null
}

variable "instance_type" {
  type        = string
  description = "Instance type for the launch template"
  default     = null
}

variable "key_name" {
  type        = string
  description = "Key pair name to attach to instances"
  default     = null
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to associate with instances"
  default     = []
}

variable "user_data" {
  type        = string
  description = "Base64-encoded user data for the instances"
  default     = null
}

#==============================================================================
# IAM INSTANCE PROFILE
#==============================================================================

variable "iam_instance_profile_name" {
  type        = string
  description = "Name of the IAM instance profile"
  default     = null
}

variable "iam_instance_profile_arn" {
  type        = string
  description = "ARN of the IAM instance profile"
  default     = null
}

#==============================================================================
# INSTANCE BEHAVIOR
#==============================================================================

variable "ebs_optimized" {
  type        = bool
  description = "Whether the instance is EBS-optimized"
  default     = null
}

variable "disable_api_termination" {
  type        = bool
  description = "Whether to enable termination protection"
  default     = null
}

variable "instance_initiated_shutdown_behavior" {
  type        = string
  description = "Shutdown behavior for the instance (stop or terminate)"
  default     = null
}

variable "update_default_version" {
  type        = bool
  description = "Whether to update the default version on each update"
  default     = null
}

#==============================================================================
# BLOCK DEVICE MAPPINGS
#==============================================================================

variable "block_device_mappings" {
  type = list(object({
    device_name = string
    ebs = object({
      volume_size           = optional(number)
      volume_type           = optional(string)
      iops                  = optional(number)
      throughput            = optional(number)
      encrypted             = optional(bool)
      kms_key_id            = optional(string)
      delete_on_termination = optional(bool)
      snapshot_id           = optional(string)
    })
  }))
  description = "List of block device mapping configurations"
  default     = []
}

#==============================================================================
# NETWORK INTERFACES
#==============================================================================

variable "network_interfaces" {
  type = list(object({
    device_index                = number
    associate_public_ip_address = optional(bool)
    subnet_id                   = optional(string)
    security_groups             = optional(list(string))
    delete_on_termination       = optional(bool)
  }))
  description = "List of network interface configurations"
  default     = []
}

#==============================================================================
# MONITORING
#==============================================================================

variable "monitoring_enabled" {
  type        = bool
  description = "Whether detailed monitoring is enabled"
  default     = false
}

#==============================================================================
# PLACEMENT
#==============================================================================

variable "placement" {
  type = object({
    availability_zone = optional(string)
    group_name        = optional(string)
    tenancy           = optional(string)
  })
  description = "Placement configuration for the instances"
  default     = null
}

#==============================================================================
# CREDIT SPECIFICATION
#==============================================================================

variable "credit_specification" {
  type = object({
    cpu_credits = string
  })
  description = "Credit specification for burstable instances"
  default     = null
}

#==============================================================================
# METADATA OPTIONS
#==============================================================================

variable "metadata_options" {
  type = object({
    http_endpoint               = optional(string)
    http_tokens                 = optional(string)
    http_put_response_hop_limit = optional(number)
    instance_metadata_tags      = optional(string)
  })
  description = "Instance metadata service configuration"
  default     = null
}

#==============================================================================
# TAG SPECIFICATIONS
#==============================================================================

variable "tag_specifications" {
  type = list(object({
    resource_type = string
    tags          = map(string)
  }))
  description = "List of tag specification configurations for resources created by the launch template"
  default     = []
}

#==============================================================================
# TAGS
#==============================================================================

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the launch template"
  default     = {}
}
