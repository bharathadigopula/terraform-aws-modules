#==============================================================================
# INSPECTOR VARIABLES
#==============================================================================
variable "account_ids" {
  description = "List of AWS account IDs to enable Inspector for"
  type        = list(string)
}

variable "resource_types" {
  description = "List of resource types to scan (EC2, ECR, LAMBDA, LAMBDA_CODE)"
  type        = list(string)
  default     = ["EC2", "ECR", "LAMBDA"]
}

#==============================================================================
# ORGANIZATION VARIABLES
#==============================================================================
variable "enable_organization_config" {
  description = "Whether to enable organization-wide Inspector configuration"
  type        = bool
  default     = false
}

variable "auto_enable_ec2" {
  description = "Auto-enable EC2 scanning for new member accounts"
  type        = bool
  default     = true
}

variable "auto_enable_ecr" {
  description = "Auto-enable ECR scanning for new member accounts"
  type        = bool
  default     = true
}

variable "auto_enable_lambda" {
  description = "Auto-enable Lambda scanning for new member accounts"
  type        = bool
  default     = true
}

variable "auto_enable_lambda_code" {
  description = "Auto-enable Lambda code scanning for new member accounts"
  type        = bool
  default     = false
}
