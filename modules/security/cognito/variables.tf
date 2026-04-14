#==============================================================================
# USER POOL VARIABLES
#==============================================================================
variable "name" {
  description = "Name of the Cognito User Pool"
  type        = string
}

variable "username_attributes" {
  description = "Attributes to use as username (email, phone_number)"
  type        = list(string)
  default     = ["email"]
}

variable "auto_verified_attributes" {
  description = "Attributes to auto-verify"
  type        = list(string)
  default     = ["email"]
}

variable "mfa_configuration" {
  description = "MFA configuration (OFF, ON, OPTIONAL)"
  type        = string
  default     = "OPTIONAL"
}

variable "deletion_protection" {
  description = "Whether deletion protection is active"
  type        = string
  default     = "ACTIVE"
}

variable "password_policy" {
  description = "Password policy configuration"
  type = object({
    minimum_length                   = optional(number, 12)
    require_lowercase                = optional(bool, true)
    require_numbers                  = optional(bool, true)
    require_symbols                  = optional(bool, true)
    require_uppercase                = optional(bool, true)
    temporary_password_validity_days = optional(number, 7)
  })
  default = {}
}

variable "schema_attributes" {
  description = "List of schema attributes"
  type = list(object({
    name                     = string
    attribute_data_type      = string
    developer_only_attribute = optional(bool, false)
    mutable                  = optional(bool, true)
    required                 = optional(bool, false)
    min_length               = optional(string)
    max_length               = optional(string)
    min_value                = optional(string)
    max_value                = optional(string)
  }))
  default = []
}

variable "recovery_mechanisms" {
  description = "Account recovery mechanisms"
  type = list(object({
    name     = string
    priority = number
  }))
  default = [
    {
      name     = "verified_email"
      priority = 1
    }
  ]
}

#==============================================================================
# DOMAIN VARIABLES
#==============================================================================
variable "domain" {
  description = "Domain name for the user pool (prefix for cognito domain, or custom domain)"
  type        = string
  default     = null
}

variable "domain_certificate_arn" {
  description = "ACM certificate ARN for custom domain"
  type        = string
  default     = null
}

#==============================================================================
# CLIENT VARIABLES
#==============================================================================
variable "clients" {
  description = "List of user pool clients"
  type = list(object({
    name                                 = string
    generate_secret                      = optional(bool, false)
    explicit_auth_flows                  = optional(list(string), ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH"])
    allowed_oauth_flows                  = optional(list(string), [])
    allowed_oauth_flows_user_pool_client = optional(bool, false)
    allowed_oauth_scopes                 = optional(list(string), [])
    callback_urls                        = optional(list(string), [])
    logout_urls                          = optional(list(string), [])
    supported_identity_providers         = optional(list(string), ["COGNITO"])
    access_token_validity                = optional(number, 1)
    id_token_validity                    = optional(number, 1)
    refresh_token_validity               = optional(number, 30)
    prevent_user_existence_errors        = optional(string, "ENABLED")
  }))
  default = []
}

#==============================================================================
# RESOURCE SERVER VARIABLES
#==============================================================================
variable "resource_servers" {
  description = "List of resource servers"
  type = list(object({
    identifier = string
    name       = string
    scopes = optional(list(object({
      scope_name        = string
      scope_description = string
    })), [])
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
