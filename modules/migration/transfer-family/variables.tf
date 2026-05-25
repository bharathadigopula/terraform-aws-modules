#==============================================================================
# TRANSFER FAMILY SERVER VARIABLES
#==============================================================================

variable "servers" {
  description = "List of Transfer Family servers to create"
  type = list(object({
    name                             = string
    certificate                      = optional(string)
    directory_id                     = optional(string)
    domain                           = optional(string)
    endpoint_type                    = optional(string)
    force_destroy                    = optional(bool)
    function                         = optional(string)
    host_key                         = optional(string)
    identity_provider_type           = optional(string)
    invocation_role                  = optional(string)
    logging_role                     = optional(string)
    post_authentication_login_banner = optional(string)
    pre_authentication_login_banner  = optional(string)
    protocols                        = optional(set(string))
    security_policy_name             = optional(string)
    sftp_authentication_methods      = optional(string)
    structured_log_destinations      = optional(set(string))
    url                              = optional(string)
    endpoint_details = optional(object({
      address_allocation_ids = optional(set(string))
      security_group_ids     = optional(set(string))
      subnet_ids             = optional(set(string))
      vpc_endpoint_id        = optional(string)
      vpc_id                 = optional(string)
    }))
    protocol_details = optional(object({
      as2_transports              = optional(set(string))
      passive_ip                  = optional(string)
      set_stat_option             = optional(string)
      tls_session_resumption_mode = optional(string)
    }))
    s3_storage_options = optional(object({
      directory_listing_optimization = optional(string)
    }))
    tags = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# TRANSFER FAMILY USER VARIABLES
#==============================================================================

variable "users" {
  description = "List of Transfer Family users to create"
  type = list(object({
    name                = string
    server_name         = optional(string)
    server_id           = optional(string)
    role                = string
    home_directory      = optional(string)
    home_directory_type = optional(string)
    policy              = optional(string)
    home_directory_mappings = optional(list(object({
      entry  = string
      target = string
    })), [])
    posix_profile = optional(object({
      uid            = number
      gid            = number
      secondary_gids = optional(set(number))
    }))
    tags = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# TRANSFER FAMILY SSH KEY VARIABLES
#==============================================================================

variable "ssh_keys" {
  description = "List of Transfer Family SSH keys to import"
  type = list(object({
    name        = string
    server_name = optional(string)
    server_id   = optional(string)
    user_name   = string
    body        = string
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
