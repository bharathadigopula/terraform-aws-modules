#==============================================================================
# DATA SET VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the Data Exchange data set"
  type        = string
}

variable "description" {
  description = "Description of the data set"
  type        = string
  default     = "Managed by Terraform"
}

variable "asset_type" {
  description = "Asset type (S3_SNAPSHOT, REDSHIFT_DATA_SHARE, etc.)"
  type        = string
  default     = "S3_SNAPSHOT"
}

#==============================================================================
# REVISION VARIABLES
#==============================================================================
variable "revisions" {
  description = "List of data set revisions"
  type = list(object({
    comment = string
    tags    = optional(map(string), {})
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
