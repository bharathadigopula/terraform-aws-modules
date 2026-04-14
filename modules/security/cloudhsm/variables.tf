#==============================================================================
# CLOUDHSM VARIABLES
#==============================================================================
variable "hsm_type" {
  description = "Type of HSM instance (e.g., hsm1.medium)"
  type        = string
  default     = "hsm1.medium"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the CloudHSM cluster"
  type        = list(string)
}

variable "source_backup_identifier" {
  description = "ID of the backup to restore the cluster from"
  type        = string
  default     = null
}

variable "hsm_instances" {
  description = "List of HSM instances to create in the cluster"
  type = list(object({
    availability_zone = string
    ip_address        = optional(string)
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
