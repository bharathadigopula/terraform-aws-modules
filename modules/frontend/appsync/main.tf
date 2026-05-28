#==============================================================================
# APPSYNC GRAPHQL APIS
#==============================================================================

resource "aws_appsync_graphql_api" "this" {
  for_each = { for api in var.graphql_apis : api.name => api }

  name                          = each.value.name
  authentication_type           = each.value.authentication_type
  schema                        = each.value.schema
  xray_enabled                  = each.value.xray_enabled
  visibility                    = each.value.visibility
  api_type                      = each.value.api_type
  introspection_config          = each.value.introspection_config
  query_depth_limit             = each.value.query_depth_limit
  resolver_count_limit          = each.value.resolver_count_limit
  merged_api_execution_role_arn = each.value.merged_api_execution_role_arn
  tags                          = merge(var.tags, each.value.tags)

  log_config {
    cloudwatch_logs_role_arn = each.value.log_config.cloudwatch_logs_role_arn
    field_log_level          = "ERROR"
    exclude_verbose_content  = try(each.value.log_config.exclude_verbose_content, true)
  }

  dynamic "user_pool_config" {
    for_each = each.value.user_pool_config != null ? [each.value.user_pool_config] : []

    content {
      default_action      = user_pool_config.value.default_action
      user_pool_id        = user_pool_config.value.user_pool_id
      app_id_client_regex = user_pool_config.value.app_id_client_regex
      aws_region          = user_pool_config.value.aws_region
    }
  }

  dynamic "openid_connect_config" {
    for_each = each.value.openid_connect_config != null ? [each.value.openid_connect_config] : []

    content {
      issuer    = openid_connect_config.value.issuer
      client_id = openid_connect_config.value.client_id
      auth_ttl  = openid_connect_config.value.auth_ttl
      iat_ttl   = openid_connect_config.value.iat_ttl
    }
  }

  dynamic "lambda_authorizer_config" {
    for_each = each.value.lambda_authorizer_config != null ? [each.value.lambda_authorizer_config] : []

    content {
      authorizer_uri                   = lambda_authorizer_config.value.authorizer_uri
      authorizer_result_ttl_in_seconds = lambda_authorizer_config.value.authorizer_result_ttl_in_seconds
      identity_validation_expression   = lambda_authorizer_config.value.identity_validation_expression
    }
  }
}

#==============================================================================
# APPSYNC API KEYS
#==============================================================================

resource "aws_appsync_api_key" "this" {
  for_each = { for key in var.api_keys : key.name => key }

  api_id      = each.value.api_name != null ? aws_appsync_graphql_api.this[each.value.api_name].id : each.value.api_id
  description = each.value.description
  expires     = each.value.expires
}

#==============================================================================
# APPSYNC DATA SOURCES
#==============================================================================

resource "aws_appsync_datasource" "this" {
  for_each = { for datasource in var.datasources : datasource.name => datasource }

  api_id           = each.value.api_name != null ? aws_appsync_graphql_api.this[each.value.api_name].id : each.value.api_id
  name             = each.value.name
  type             = each.value.type
  description      = each.value.description
  service_role_arn = each.value.service_role_arn

  dynamic "lambda_config" {
    for_each = each.value.lambda_config != null ? [each.value.lambda_config] : []

    content {
      function_arn = lambda_config.value.function_arn
    }
  }

  dynamic "http_config" {
    for_each = each.value.http_config != null ? [each.value.http_config] : []

    content {
      endpoint = http_config.value.endpoint
    }
  }

  dynamic "dynamodb_config" {
    for_each = each.value.dynamodb_config != null ? [each.value.dynamodb_config] : []

    content {
      table_name             = dynamodb_config.value.table_name
      region                 = dynamodb_config.value.region
      use_caller_credentials = dynamodb_config.value.use_caller_credentials
      versioned              = dynamodb_config.value.versioned
    }
  }

  dynamic "event_bridge_config" {
    for_each = each.value.event_bridge_config != null ? [each.value.event_bridge_config] : []

    content {
      event_bus_arn = event_bridge_config.value.event_bus_arn
    }
  }
}

#==============================================================================
# APPSYNC RESOLVERS
#==============================================================================

resource "aws_appsync_resolver" "this" {
  for_each = { for resolver in var.resolvers : "${resolver.api_name}:${resolver.type}:${resolver.field}" => resolver }

  api_id            = each.value.api_name != null ? aws_appsync_graphql_api.this[each.value.api_name].id : each.value.api_id
  type              = each.value.type
  field             = each.value.field
  data_source       = each.value.data_source
  request_template  = each.value.request_template
  response_template = each.value.response_template
  code              = each.value.code
  kind              = each.value.kind
  max_batch_size    = each.value.max_batch_size

  dynamic "runtime" {
    for_each = each.value.runtime != null ? [each.value.runtime] : []

    content {
      name            = runtime.value.name
      runtime_version = runtime.value.runtime_version
    }
  }

  dynamic "pipeline_config" {
    for_each = each.value.pipeline_config != null ? [each.value.pipeline_config] : []

    content {
      functions = pipeline_config.value.functions
    }
  }
}
