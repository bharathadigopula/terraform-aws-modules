#==============================================================================
# GUARDDUTY DETECTOR VARIABLES
#==============================================================================
variable "enable" {
  description = "Enable GuardDuty detector"
  type        = bool
  default     = true
}

variable "finding_publishing_frequency" {
  description = "Frequency of finding notifications (FIFTEEN_MINUTES, ONE_HOUR, SIX_HOURS)"
  type        = string
  default     = "SIX_HOURS"
}

variable "enable_s3_logs" {
  description = "Enable S3 data event logs analysis"
  type        = bool
  default     = true
}

variable "enable_kubernetes_audit_logs" {
  description = "Enable Kubernetes audit logs analysis"
  type        = bool
  default     = true
}

variable "enable_malware_protection" {
  description = "Enable malware protection for EBS volumes"
  type        = bool
  default     = true
}

#==============================================================================
# ORGANIZATION VARIABLES
#==============================================================================
variable "admin_account_id" {
  description = "AWS account ID to designate as GuardDuty delegated admin"
  type        = string
  default     = null
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
