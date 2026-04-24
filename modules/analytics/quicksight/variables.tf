#==============================================================================
# SUBSCRIPTION VARIABLES
#==============================================================================
variable "create_subscription" {
  description = "Whether to create a QuickSight account subscription"
  type        = bool
  default     = false
}

variable "account_name" {
  description = "QuickSight account name"
  type        = string
  default     = null
}

variable "authentication_method" {
  description = "Authentication method (IAM_AND_QUICKSIGHT, IAM_ONLY, ACTIVE_DIRECTORY)"
  type        = string
  default     = "IAM_AND_QUICKSIGHT"
}

variable "edition" {
  description = "QuickSight edition (STANDARD or ENTERPRISE)"
  type        = string
  default     = "ENTERPRISE"
}

variable "notification_email" {
  description = "Notification email address"
  type        = string
  default     = null
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
  default     = null
}

variable "active_directory_name" {
  description = "Active Directory name"
  type        = string
  default     = null
}

variable "admin_group" {
  description = "Admin group for Active Directory"
  type        = list(string)
  default     = null
}

variable "author_group" {
  description = "Author group for Active Directory"
  type        = list(string)
  default     = null
}

variable "reader_group" {
  description = "Reader group for Active Directory"
  type        = list(string)
  default     = null
}

variable "contact_number" {
  description = "Contact number"
  type        = string
  default     = null
}

variable "directory_id" {
  description = "Directory ID"
  type        = string
  default     = null
}

variable "email_address" {
  description = "Admin email address"
  type        = string
  default     = null
}

variable "first_name" {
  description = "Admin first name"
  type        = string
  default     = null
}

variable "last_name" {
  description = "Admin last name"
  type        = string
  default     = null
}

variable "realm" {
  description = "Realm"
  type        = string
  default     = null
}

#==============================================================================
# USER VARIABLES
#==============================================================================
variable "users" {
  description = "List of QuickSight users"
  type = list(object({
    user_name     = string
    email         = string
    identity_type = optional(string, "IAM")
    user_role     = optional(string, "READER")
    namespace     = optional(string, "default")
    session_name  = optional(string)
    iam_arn       = optional(string)
  }))
  default = []
}

#==============================================================================
# DATA SOURCE VARIABLES
#==============================================================================
variable "data_sources" {
  description = "List of QuickSight data sources"
  type = list(object({
    data_source_id = string
    name           = string
    type           = string
    parameters = optional(object({
      s3 = optional(object({
        manifest_bucket = string
        manifest_key    = string
      }))
    }))
    tags = optional(map(string), {})
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
