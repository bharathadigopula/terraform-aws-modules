#==============================================================================
# EBS VOLUME VARIABLES
#==============================================================================
variable "availability_zone" {
  description = "The AZ where the EBS volume will be created"
  type        = string
}

variable "size" {
  description = "The size of the volume in GiBs"
  type        = number
}

variable "type" {
  description = "The type of EBS volume"
  type        = string
  default     = "gp3"
}

variable "iops" {
  description = "The amount of IOPS to provision for the volume"
  type        = number
  default     = null
}

variable "throughput" {
  description = "The throughput in MiB/s for the volume (valid for gp3 only)"
  type        = number
  default     = null
}

variable "encrypted" {
  description = "Whether to enable volume encryption"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "ARN of the KMS key to use for volume encryption"
  type        = string
  default     = null
}

variable "snapshot_id" {
  description = "A snapshot to base the EBS volume off of"
  type        = string
  default     = null
}

variable "multi_attach_enabled" {
  description = "Whether to enable multi-attach for the volume (io1/io2 only)"
  type        = bool
  default     = false
}

variable "final_snapshot" {
  description = "Whether to create a final snapshot when the volume is destroyed"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Map of tags to assign to the volume"
  type        = map(string)
  default     = {}
}
