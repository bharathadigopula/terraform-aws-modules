#==============================================================================
# INSTANCE IDENTITY
#==============================================================================

variable "name" {
  type        = string
  description = "Name prefix for the EC2 instances"
}

variable "ami" {
  type        = string
  description = "AMI ID to launch the instances from"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "instance_count" {
  type        = number
  description = "Number of EC2 instances to create"
  default     = 1
}

#==============================================================================
# NETWORKING
#==============================================================================

variable "subnet_id" {
  type        = string
  description = "Subnet ID to launch the instances in"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to attach"
  default     = []
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Whether to associate a public IP address"
  default     = false
}

variable "availability_zone" {
  type        = string
  description = "AZ to launch the instances in"
  default     = null
}

#==============================================================================
# ACCESS AND SECURITY
#==============================================================================

variable "key_name" {
  type        = string
  description = "Key pair name for SSH access"
  default     = null
}

variable "iam_instance_profile" {
  type        = string
  description = "IAM instance profile name or ARN"
  default     = null
}

variable "disable_api_termination" {
  type        = bool
  description = "Enable termination protection"
  default     = false
}

variable "instance_initiated_shutdown_behavior" {
  type        = string
  description = "Shutdown behavior: stop or terminate"
  default     = "stop"
}

#==============================================================================
# USER DATA
#==============================================================================

variable "user_data" {
  type        = string
  description = "User data script (plain text)"
  default     = null
}

variable "user_data_base64" {
  type        = string
  description = "User data script (base64-encoded)"
  default     = null
}

#==============================================================================
# MONITORING AND PERFORMANCE
#==============================================================================

variable "monitoring" {
  type        = bool
  description = "Enable detailed CloudWatch monitoring"
  default     = true
}

variable "ebs_optimized" {
  type        = bool
  description = "Enable EBS optimization"
  default     = true
}

variable "cpu_credits" {
  type        = string
  description = "CPU credit option for burstable instances: standard or unlimited"
  default     = null
}

#==============================================================================
# PLACEMENT
#==============================================================================

variable "tenancy" {
  type        = string
  description = "Instance tenancy: default, dedicated, or host"
  default     = "default"
}

variable "host_id" {
  type        = string
  description = "Dedicated Host ID for the instance"
  default     = null
}

#==============================================================================
# METADATA OPTIONS
#==============================================================================

variable "metadata_options" {
  type = object({
    http_endpoint               = optional(string, "enabled")
    http_tokens                 = optional(string, "required")
    http_put_response_hop_limit = optional(number, 1)
    instance_metadata_tags      = optional(string, "disabled")
  })
  description = "Instance metadata service configuration"
  default     = {}
}

#==============================================================================
# ROOT BLOCK DEVICE
#==============================================================================

variable "root_block_device" {
  type = object({
    volume_type           = optional(string, "gp3")
    volume_size           = optional(number, 20)
    iops                  = optional(number, null)
    throughput            = optional(number, null)
    encrypted             = optional(bool, true)
    kms_key_id            = optional(string, null)
    delete_on_termination = optional(bool, true)
  })
  description = "Root EBS volume configuration"
  default     = {}
}

#==============================================================================
# ADDITIONAL EBS BLOCK DEVICES
#==============================================================================

variable "ebs_block_devices" {
  type = list(object({
    device_name           = string
    volume_type           = optional(string, "gp3")
    volume_size           = optional(number, 20)
    iops                  = optional(number, null)
    throughput            = optional(number, null)
    encrypted             = optional(bool, true)
    kms_key_id            = optional(string, null)
    delete_on_termination = optional(bool, true)
    snapshot_id           = optional(string, null)
  }))
  description = "List of additional EBS volumes to attach"
  default     = []
}

#==============================================================================
# TAGS
#==============================================================================

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}
