#==============================================================================
# API
#==============================================================================

output "api_id" {
  description = "ID of the API Gateway"
  value       = local.is_v2 ? try(aws_apigatewayv2_api.this[0].id, null) : try(aws_api_gateway_rest_api.this[0].id, null)
}

output "api_endpoint" {
  description = "Base URL of the API Gateway endpoint"
  value       = local.is_v2 ? try(aws_apigatewayv2_api.this[0].api_endpoint, null) : try(aws_api_gateway_stage.this[0].invoke_url, null)
}

output "api_arn" {
  description = "ARN of the API Gateway"
  value       = local.is_v2 ? try(aws_apigatewayv2_api.this[0].arn, null) : try(aws_api_gateway_rest_api.this[0].arn, null)
}

output "execution_arn" {
  description = "Execution ARN used to invoke the API from Lambda or other services"
  value       = local.is_v2 ? try(aws_apigatewayv2_api.this[0].execution_arn, null) : try(aws_api_gateway_rest_api.this[0].execution_arn, null)
}

#==============================================================================
# STAGE
#==============================================================================

output "stage_id" {
  description = "ID of the API Gateway stage"
  value       = local.is_v2 ? try(aws_apigatewayv2_stage.this[0].id, null) : try(aws_api_gateway_stage.this[0].id, null)
}

output "stage_invoke_url" {
  description = "Invoke URL of the API Gateway stage"
  value       = local.is_v2 ? try(aws_apigatewayv2_stage.this[0].invoke_url, null) : try(aws_api_gateway_stage.this[0].invoke_url, null)
}

#==============================================================================
# CUSTOM DOMAIN
#==============================================================================

output "domain_name_id" {
  description = "ID of the custom domain name"
  value       = try(aws_apigatewayv2_domain_name.this[0].id, null)
}

output "domain_name_configuration" {
  description = "Domain name configuration including target domain and hosted zone ID"
  value       = try(aws_apigatewayv2_domain_name.this[0].domain_name_configuration, null)
}
