#==============================================================================
# LOCALS
#==============================================================================

locals {
  is_v2  = var.api_type == "http"
  is_v1  = var.api_type == "rest"

  default_log_format = jsonencode({
    requestId      = "$context.requestId"
    ip             = "$context.identity.sourceIp"
    caller         = "$context.identity.caller"
    user           = "$context.identity.user"
    requestTime    = "$context.requestTime"
    httpMethod     = "$context.httpMethod"
    resourcePath   = "$context.resourcePath"
    status         = "$context.status"
    protocol       = "$context.protocol"
    responseLength = "$context.responseLength"
  })
}

#==============================================================================
# API GATEWAY V2 (HTTP / WEBSOCKET)
#==============================================================================

resource "aws_apigatewayv2_api" "this" {
  count = local.is_v2 ? 1 : 0

  name          = var.name
  description   = var.description
  protocol_type = var.protocol_type

  dynamic "cors_configuration" {
    for_each = var.cors_configuration != null ? [var.cors_configuration] : []

    content {
      allow_origins     = cors_configuration.value.allow_origins
      allow_methods     = cors_configuration.value.allow_methods
      allow_headers     = cors_configuration.value.allow_headers
      expose_headers    = cors_configuration.value.expose_headers
      max_age           = cors_configuration.value.max_age
      allow_credentials = cors_configuration.value.allow_credentials
    }
  }

  tags = var.tags
}

#==============================================================================
# V2 STAGE
#==============================================================================

resource "aws_apigatewayv2_stage" "this" {
  count = local.is_v2 ? 1 : 0

  api_id      = aws_apigatewayv2_api.this[0].id
  name        = var.stage_name
  auto_deploy = var.stage_auto_deploy

  default_route_settings {
    throttling_burst_limit = var.throttling_burst_limit
    throttling_rate_limit  = var.throttling_rate_limit
  }

  dynamic "access_log_settings" {
    for_each = var.access_log_settings != null ? [var.access_log_settings] : []

    content {
      destination_arn = access_log_settings.value.destination_arn
      format          = coalesce(access_log_settings.value.format, local.default_log_format)
    }
  }

  tags = var.tags
}

#==============================================================================
# V2 INTEGRATIONS
#==============================================================================

resource "aws_apigatewayv2_integration" "this" {
  for_each = local.is_v2 ? var.routes : {}

  api_id             = aws_apigatewayv2_api.this[0].id
  integration_uri    = each.value.integration_uri
  integration_type   = each.value.integration_type
  integration_method = each.value.integration_method
  payload_format_version = "2.0"
}

#==============================================================================
# V2 ROUTES
#==============================================================================

resource "aws_apigatewayv2_route" "this" {
  for_each = local.is_v2 ? var.routes : {}

  api_id    = aws_apigatewayv2_api.this[0].id
  route_key = coalesce(each.value.route_key, each.key)
  target    = "integrations/${aws_apigatewayv2_integration.this[each.key].id}"

  authorization_type = each.value.authorization_type
  authorizer_id      = each.value.authorizer_id
}

#==============================================================================
# V2 CUSTOM DOMAIN
#==============================================================================

resource "aws_apigatewayv2_domain_name" "this" {
  count = local.is_v2 && var.domain_name != null ? 1 : 0

  domain_name = var.domain_name

  domain_name_configuration {
    certificate_arn = var.domain_name_certificate_arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }

  tags = var.tags
}

resource "aws_apigatewayv2_api_mapping" "this" {
  count = local.is_v2 && var.domain_name != null ? 1 : 0

  api_id      = aws_apigatewayv2_api.this[0].id
  domain_name = aws_apigatewayv2_domain_name.this[0].domain_name
  stage       = aws_apigatewayv2_stage.this[0].id
}

#==============================================================================
# API GATEWAY V1 (REST)
#==============================================================================

resource "aws_api_gateway_rest_api" "this" {
  count = local.is_v1 ? 1 : 0

  name           = var.name
  description    = var.description
  api_key_source = var.api_key_source
  body           = var.body

  endpoint_configuration {
    types            = var.endpoint_configuration.types
    vpc_endpoint_ids = length(var.endpoint_configuration.vpc_endpoint_ids) > 0 ? var.endpoint_configuration.vpc_endpoint_ids : null
  }

  tags = var.tags
}

#==============================================================================
# V1 DEPLOYMENT
#==============================================================================

resource "aws_api_gateway_deployment" "this" {
  count = local.is_v1 ? 1 : 0

  rest_api_id = aws_api_gateway_rest_api.this[0].id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_rest_api.this[0].body,
      aws_api_gateway_rest_api.this[0].id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

#==============================================================================
# V1 STAGE
#==============================================================================

resource "aws_api_gateway_stage" "this" {
  count = local.is_v1 ? 1 : 0

  rest_api_id   = aws_api_gateway_rest_api.this[0].id
  deployment_id = aws_api_gateway_deployment.this[0].id
  stage_name    = var.stage_name

  dynamic "access_log_settings" {
    for_each = var.access_log_settings != null ? [var.access_log_settings] : []

    content {
      destination_arn = access_log_settings.value.destination_arn
    }
  }

  tags = var.tags
}

resource "aws_api_gateway_method_settings" "this" {
  count = local.is_v1 ? 1 : 0

  rest_api_id = aws_api_gateway_rest_api.this[0].id
  stage_name  = aws_api_gateway_stage.this[0].stage_name
  method_path = "*/*"

  settings {
    throttling_burst_limit = var.throttling_burst_limit
    throttling_rate_limit  = var.throttling_rate_limit
    logging_level          = "INFO"
    metrics_enabled        = true
    data_trace_enabled     = false
  }
}
