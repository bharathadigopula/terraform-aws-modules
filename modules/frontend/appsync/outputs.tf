#==============================================================================
# APPSYNC OUTPUTS
#==============================================================================

output "graphql_api_ids" {
  description = "Map of AppSync GraphQL API IDs"
  value       = { for k, v in aws_appsync_graphql_api.this : k => v.id }
}

output "graphql_api_arns" {
  description = "Map of AppSync GraphQL API ARNs"
  value       = { for k, v in aws_appsync_graphql_api.this : k => v.arn }
}

output "api_key_ids" {
  description = "Map of AppSync API key IDs"
  value       = { for k, v in aws_appsync_api_key.this : k => v.id }
}

output "datasource_ids" {
  description = "Map of AppSync data source IDs"
  value       = { for k, v in aws_appsync_datasource.this : k => v.id }
}

output "resolver_ids" {
  description = "Map of AppSync resolver IDs"
  value       = { for k, v in aws_appsync_resolver.this : k => v.id }
}
