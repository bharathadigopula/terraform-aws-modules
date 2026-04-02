#==============================================================================
# API
#==============================================================================

output "api_id" {
  value = local.is_v2 ? try(aws_apigatewayv2_api.this[0].id, null) : try(aws_api_gateway_rest_api.this[0].id, null)
}

output "api_endpoint" {
  value = local.is_v2 ? try(aws_apigatewayv2_api.this[0].api_endpoint, null) : try(aws_api_gateway_stage.this[0].invoke_url, null)
}

output "api_arn" {
  value = local.is_v2 ? try(aws_apigatewayv2_api.this[0].arn, null) : try(aws_api_gateway_rest_api.this[0].arn, null)
}

output "execution_arn" {
  value = local.is_v2 ? try(aws_apigatewayv2_api.this[0].execution_arn, null) : try(aws_api_gateway_rest_api.this[0].execution_arn, null)
}

#==============================================================================
# STAGE
#==============================================================================

output "stage_id" {
  value = local.is_v2 ? try(aws_apigatewayv2_stage.this[0].id, null) : try(aws_api_gateway_stage.this[0].id, null)
}

output "stage_invoke_url" {
  value = local.is_v2 ? try(aws_apigatewayv2_stage.this[0].invoke_url, null) : try(aws_api_gateway_stage.this[0].invoke_url, null)
}

#==============================================================================
# CUSTOM DOMAIN
#==============================================================================

output "domain_name_id" {
  value = try(aws_apigatewayv2_domain_name.this[0].id, null)
}

output "domain_name_configuration" {
  value = try(aws_apigatewayv2_domain_name.this[0].domain_name_configuration, null)
}
