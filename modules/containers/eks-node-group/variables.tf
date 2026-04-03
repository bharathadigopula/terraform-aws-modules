#==============================================================================
# REQUIRED VARIABLES
#==============================================================================

variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role ARN for the EKS node group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where the node group will be launched"
  type        = list(string)
}

#==============================================================================
# INSTANCE CONFIGURATION
#==============================================================================

variable "instance_types" {
  description = "List of EC2 instance types for the node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "capacity_type" {
  description = "Type of capacity associated with the node group (ON_DEMAND or SPOT)"
  type        = string
  default     = "ON_DEMAND"

  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.capacity_type)
    error_message = "capacity_type must be either ON_DEMAND or SPOT."
  }
}

variable "disk_size" {
  description = "Disk size in GiB for worker nodes"
  type        = number
  default     = 20
}

variable "ami_type" {
  description = "AMI type for the EKS node group"
  type        = string
  default     = "AL2_x86_64"

  validation {
    condition = contains([
      "AL2_x86_64",
      "AL2_x86_64_GPU",
      "AL2_ARM_64",
      "BOTTLEROCKET_x86_64",
      "BOTTLEROCKET_ARM_64",
    ], var.ami_type)
    error_message = "ami_type must be one of: AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, BOTTLEROCKET_x86_64, BOTTLEROCKET_ARM_64."
  }
}

#==============================================================================
# SCALING CONFIGURATION
#==============================================================================

variable "scaling_config" {
  description = "Scaling configuration for the node group"
  type = object({
    desired_size = number
    min_size     = number
    max_size     = number
  })
  default = {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }
}

#==============================================================================
# UPDATE CONFIGURATION
#==============================================================================

variable "update_config" {
  description = "Update configuration for the node group (set either max_unavailable or max_unavailable_percentage, not both)"
  type = object({
    max_unavailable            = optional(number)
    max_unavailable_percentage = optional(number)
  })
  default = {
    max_unavailable = 1
  }
}

#==============================================================================
# LABELS AND TAINTS
#==============================================================================

variable "labels" {
  description = "Key-value map of Kubernetes labels to apply to the node group"
  type        = map(string)
  default     = {}
}

variable "taints" {
  description = "List of Kubernetes taints to apply to the node group"
  type = list(object({
    key    = string
    value  = optional(string)
    effect = string
  }))
  default = []
}

#==============================================================================
# LAUNCH TEMPLATE
#==============================================================================

variable "launch_template" {
  description = "Launch template configuration for the node group"
  type = object({
    id      = string
    version = string
  })
  default = null
}

#==============================================================================
# REMOTE ACCESS
#==============================================================================

variable "remote_access" {
  description = "Remote access configuration for the node group"
  type = object({
    ec2_ssh_key               = optional(string)
    source_security_group_ids = optional(list(string))
  })
  default = null
}

#==============================================================================
# MISCELLANEOUS
#==============================================================================

variable "force_update_version" {
  description = "Force version update if existing pods are unable to be drained due to a pod disruption budget"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Key-value map of tags to apply to the node group"
  type        = map(string)
  default     = {}
}
