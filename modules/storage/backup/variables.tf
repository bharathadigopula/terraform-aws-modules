#==============================================================================
# BACKUP VAULT VARIABLES
#==============================================================================
variable "vault_name" {
  description = "Name of the AWS Backup vault"
  type        = string
}

variable "kms_key_arn" {
  description = "ARN of the KMS key used to encrypt backup vault"
  type        = string
}

variable "force_destroy_vault" {
  description = "Whether to allow force destroying the backup vault and all recovery points"
  type        = bool
  default     = false
}

#==============================================================================
# BACKUP PLAN VARIABLES
#==============================================================================
variable "plan_name" {
  description = "Name of the AWS Backup plan"
  type        = string
}

variable "plan_rules" {
  description = "List of backup plan rule objects defining schedule, lifecycle, and copy actions"
  type = list(object({
    rule_name                = string
    target_vault_name        = string
    schedule                 = string
    start_window             = number
    completion_window        = number
    enable_continuous_backup = optional(bool, false)
    lifecycle = optional(object({
      cold_storage_after = optional(number)
      delete_after       = optional(number)
    }))
    copy_action = optional(list(object({
      destination_vault_arn = string
      lifecycle = optional(object({
        cold_storage_after = optional(number)
        delete_after       = optional(number)
      }))
    })), [])
  }))
}

#==============================================================================
# BACKUP SELECTION VARIABLES
#==============================================================================
variable "selection_name" {
  description = "Name of the backup selection"
  type        = string
}

variable "selection_iam_role_arn" {
  description = "IAM role ARN used by AWS Backup to authenticate when performing backup and restore operations"
  type        = string
}

variable "selection_resources" {
  description = "List of resource ARNs to be backed up"
  type        = list(string)
  default     = []
}

variable "selection_conditions" {
  description = "Conditions object for resource selection using string match operators"
  type = object({
    string_equals     = optional(list(object({ key = string, value = string })), [])
    string_not_equals = optional(list(object({ key = string, value = string })), [])
    string_like       = optional(list(object({ key = string, value = string })), [])
    string_not_like   = optional(list(object({ key = string, value = string })), [])
  })
  default = {
    string_equals     = []
    string_not_equals = []
    string_like       = []
    string_not_like   = []
  }
}

variable "selection_tags" {
  description = "List of tag-based conditions for resource selection"
  type = list(object({
    type  = string
    key   = string
    value = string
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
