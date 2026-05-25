#==============================================================================
# AMPLIFY APP VARIABLES
#==============================================================================

variable "apps" {
  description = "List of Amplify apps to create"
  type = list(object({
    name                          = string
    description                   = optional(string)
    repository                    = optional(string)
    platform                      = optional(string)
    access_token                  = optional(string)
    oauth_token                   = optional(string)
    build_spec                    = optional(string)
    custom_headers                = optional(string)
    basic_auth_credentials        = optional(string)
    enable_basic_auth             = optional(bool)
    enable_branch_auto_build      = optional(bool)
    enable_branch_auto_deletion   = optional(bool)
    enable_auto_branch_creation   = optional(bool)
    auto_branch_creation_patterns = optional(set(string))
    environment_variables         = optional(map(string))
    iam_service_role_arn          = optional(string)
    compute_role_arn              = optional(string)
    custom_rules = optional(list(object({
      source    = string
      target    = string
      status    = optional(string)
      condition = optional(string)
    })), [])
    cache_config = optional(object({
      type = string
    }))
    tags = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# AMPLIFY BRANCH VARIABLES
#==============================================================================

variable "branches" {
  description = "List of Amplify branches to create"
  type = list(object({
    app_name                      = optional(string)
    app_id                        = optional(string)
    branch_name                   = string
    description                   = optional(string)
    display_name                  = optional(string)
    framework                     = optional(string)
    stage                         = optional(string)
    ttl                           = optional(string)
    backend_environment_arn       = optional(string)
    basic_auth_credentials        = optional(string)
    enable_auto_build             = optional(bool)
    enable_basic_auth             = optional(bool)
    enable_notification           = optional(bool)
    enable_performance_mode       = optional(bool)
    enable_pull_request_preview   = optional(bool)
    enable_skew_protection        = optional(bool)
    environment_variables         = optional(map(string))
    pull_request_environment_name = optional(string)
    tags                          = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# AMPLIFY DOMAIN VARIABLES
#==============================================================================

variable "domain_associations" {
  description = "List of Amplify domain associations to create"
  type = list(object({
    app_name               = optional(string)
    app_id                 = optional(string)
    domain_name            = string
    enable_auto_sub_domain = optional(bool)
    wait_for_verification  = optional(bool)
    certificate_settings = optional(object({
      type                   = string
      custom_certificate_arn = optional(string)
    }))
    sub_domains = list(object({
      branch_name = string
      prefix      = string
    }))
  }))
  default = []
}

#==============================================================================
# COMMON VARIABLES
#==============================================================================

variable "tags" {
  description = "Tags to apply to all supported resources"
  type        = map(string)
  default     = {}
}
