#==============================================================================
# GATEWAY VARIABLES
#==============================================================================
variable "gateway_name" {
  description = "Name of the Storage Gateway"
  type        = string
}

variable "gateway_type" {
  description = "Type of the gateway (FILE_S3, FILE_FSX_SMB, STORED, CACHED, VTL)"
  type        = string
  default     = "FILE_S3"
}

variable "gateway_timezone" {
  description = "Time zone for the gateway in GMT format"
  type        = string
  default     = "GMT"
}

variable "gateway_ip_address" {
  description = "IP address of the gateway VM to activate"
  type        = string
  default     = null
}

variable "activation_key" {
  description = "Gateway activation key used during resource creation"
  type        = string
  default     = null
}

#==============================================================================
# SMB SETTINGS VARIABLES
#==============================================================================
variable "smb_active_directory_settings" {
  description = "Active Directory settings for SMB authentication on the gateway"
  type = object({
    domain_name = string
    username    = string
    password    = string
  })
  default = null
}

variable "smb_guest_password" {
  description = "Password for SMB guest user access"
  type        = string
  default     = null
  sensitive   = true
}

#==============================================================================
# CLOUDWATCH VARIABLES
#==============================================================================
variable "cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch log group for gateway logging"
  type        = string
  default     = null
}

#==============================================================================
# NFS FILE SHARE VARIABLES
#==============================================================================
variable "nfs_file_shares" {
  description = "List of NFS file share configurations to create on the gateway"
  type = list(object({
    client_list           = list(string)
    file_share_name       = string
    location_arn          = string
    role_arn              = string
    kms_encrypted         = optional(bool, true)
    kms_key_arn           = optional(string)
    default_storage_class = optional(string, "S3_STANDARD")
    squash                = optional(string, "RootSquash")
  }))
  default = []
}

#==============================================================================
# SMB FILE SHARE VARIABLES
#==============================================================================
variable "smb_file_shares" {
  description = "List of SMB file share configurations to create on the gateway"
  type = list(object({
    file_share_name       = string
    location_arn          = string
    role_arn              = string
    kms_encrypted         = optional(bool, true)
    kms_key_arn           = optional(string)
    default_storage_class = optional(string, "S3_STANDARD")
    authentication        = optional(string, "ActiveDirectory")
  }))
  default = []
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================
variable "tags" {
  description = "Map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}
