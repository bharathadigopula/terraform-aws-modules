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
# ACM VARIABLES
#==============================================================================

variable "acm_domain_name" {
  description = "Value for the domain_name input of the acm module"
  type        = any
}

#==============================================================================
# CLOUDHSM VARIABLES
#==============================================================================

variable "cloudhsm_subnet_ids" {
  description = "Value for the subnet_ids input of the cloudhsm module"
  type        = any
}

#==============================================================================
# COGNITO VARIABLES
#==============================================================================

variable "cognito_name" {
  description = "Value for the name input of the cognito module"
  type        = any
}

#==============================================================================
# DIRECTORY SERVICE VARIABLES
#==============================================================================

variable "directory_service_name" {
  description = "Value for the name input of the directory-service module"
  type        = any
}

variable "directory_service_password" {
  description = "Value for the password input of the directory-service module"
  type        = any
  sensitive   = true
}

variable "directory_service_vpc_id" {
  description = "Value for the vpc_id input of the directory-service module"
  type        = any
}

variable "directory_service_subnet_ids" {
  description = "Value for the subnet_ids input of the directory-service module"
  type        = any
}

#==============================================================================
# IAM IDENTITY CENTER VARIABLES
#==============================================================================

variable "iam_identity_center_instance_arn" {
  description = "Value for the instance_arn input of the iam-identity-center module"
  type        = any
}

#==============================================================================
# INSPECTOR VARIABLES
#==============================================================================

variable "inspector_account_ids" {
  description = "Value for the account_ids input of the inspector module"
  type        = any
}

#==============================================================================
# RAM VARIABLES
#==============================================================================

variable "ram_name" {
  description = "Value for the name input of the ram module"
  type        = any
}

#==============================================================================
# SECRETS MANAGER VARIABLES
#==============================================================================

variable "secrets_manager_name" {
  description = "Value for the name input of the secrets-manager module"
  type        = any
}

#==============================================================================
# SECURITY LAKE VARIABLES
#==============================================================================

variable "security_lake_meta_store_manager_role_arn" {
  description = "Value for the meta_store_manager_role_arn input of the security-lake module"
  type        = any
}

variable "security_lake_configurations" {
  description = "Value for the configurations input of the security-lake module"
  type        = any
}

#==============================================================================
# WAF VARIABLES
#==============================================================================

variable "waf_name" {
  description = "Value for the name input of the waf module"
  type        = any
}
