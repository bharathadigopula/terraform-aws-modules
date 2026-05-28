#==============================================================================
# COMMON VARIABLES
#==============================================================================

variable "aws_region" {
  description = "AWS region for the example provider"
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "Tags to apply to supported resources"
  type        = map(string)
  default     = {}
}

#==============================================================================
# APPLICATION MIGRATION VARIABLES
#==============================================================================

variable "application_migration_resources" {
  description = "Application Migration Cloud Control resources to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# DATASYNC VARIABLES
#==============================================================================

variable "datasync_s3_locations" {
  description = "DataSync S3 locations to create"
  type        = list(any)
  default     = []
}

variable "datasync_tasks" {
  description = "DataSync tasks to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# MIGRATION HUB VARIABLES
#==============================================================================

variable "migration_hub_resources" {
  description = "Migration Hub Cloud Control resources to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# SNOW FAMILY VARIABLES
#==============================================================================

variable "snow_family_resources" {
  description = "Snow Family Cloud Control resources to create"
  type        = list(any)
  default     = []
}

#==============================================================================
# TRANSFER FAMILY VARIABLES
#==============================================================================

variable "transfer_family_servers" {
  description = "Transfer Family servers to create"
  type        = list(any)
  default     = []
}

variable "transfer_family_users" {
  description = "Transfer Family users to create"
  type        = list(any)
  default     = []
}

variable "transfer_family_ssh_keys" {
  description = "Transfer Family SSH keys to import"
  type        = list(any)
  default     = []
}
