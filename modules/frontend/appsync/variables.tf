#==============================================================================
# APPSYNC GRAPHQL API VARIABLES
#==============================================================================

variable "graphql_apis" {
  description = "List of AppSync GraphQL APIs to create"
  type = list(object({
    name                          = string
    authentication_type           = string
    schema                        = optional(string)
    xray_enabled                  = optional(bool)
    visibility                    = optional(string)
    api_type                      = optional(string)
    introspection_config          = optional(string)
    query_depth_limit             = optional(number)
    resolver_count_limit          = optional(number)
    merged_api_execution_role_arn = optional(string)
    log_config = object({
      cloudwatch_logs_role_arn = string
      field_log_level          = optional(string)
      exclude_verbose_content  = optional(bool)
    })
    user_pool_config = optional(object({
      default_action      = string
      user_pool_id        = string
      app_id_client_regex = optional(string)
      aws_region          = optional(string)
    }))
    openid_connect_config = optional(object({
      issuer    = string
      client_id = optional(string)
      auth_ttl  = optional(number)
      iat_ttl   = optional(number)
    }))
    lambda_authorizer_config = optional(object({
      authorizer_uri                   = string
      authorizer_result_ttl_in_seconds = optional(number)
      identity_validation_expression   = optional(string)
    }))
    tags = optional(map(string), {})
  }))
  default = []
}

#==============================================================================
# APPSYNC API KEY VARIABLES
#==============================================================================

variable "api_keys" {
  description = "List of AppSync API keys to create"
  type = list(object({
    name        = string
    api_name    = optional(string)
    api_id      = optional(string)
    description = optional(string)
    expires     = optional(string)
  }))
  default = []
}

#==============================================================================
# APPSYNC DATA SOURCE VARIABLES
#==============================================================================

variable "datasources" {
  description = "List of AppSync data sources to create"
  type = list(object({
    name             = string
    api_name         = optional(string)
    api_id           = optional(string)
    type             = string
    description      = optional(string)
    service_role_arn = optional(string)
    lambda_config = optional(object({
      function_arn = string
    }))
    http_config = optional(object({
      endpoint = string
    }))
    dynamodb_config = optional(object({
      table_name             = string
      region                 = optional(string)
      use_caller_credentials = optional(bool)
      versioned              = optional(bool)
    }))
    event_bridge_config = optional(object({
      event_bus_arn = string
    }))
  }))
  default = []
}

#==============================================================================
# APPSYNC RESOLVER VARIABLES
#==============================================================================

variable "resolvers" {
  description = "List of AppSync resolvers to create"
  type = list(object({
    api_name          = optional(string)
    api_id            = optional(string)
    type              = string
    field             = string
    data_source       = optional(string)
    request_template  = optional(string)
    response_template = optional(string)
    code              = optional(string)
    kind              = optional(string)
    max_batch_size    = optional(number)
    runtime = optional(object({
      name            = string
      runtime_version = string
    }))
    pipeline_config = optional(object({
      functions = optional(list(string))
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
