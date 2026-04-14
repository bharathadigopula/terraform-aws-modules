#==============================================================================
# USER POOL OUTPUTS
#==============================================================================
output "user_pool_id" {
  description = "ID of the Cognito User Pool"
  value       = aws_cognito_user_pool.this.id
}

output "user_pool_arn" {
  description = "ARN of the Cognito User Pool"
  value       = aws_cognito_user_pool.this.arn
}

output "user_pool_endpoint" {
  description = "Endpoint of the Cognito User Pool"
  value       = aws_cognito_user_pool.this.endpoint
}

#==============================================================================
# DOMAIN OUTPUTS
#==============================================================================
output "domain" {
  description = "Domain of the user pool"
  value       = try(aws_cognito_user_pool_domain.this[0].domain, null)
}

output "cloudfront_distribution_arn" {
  description = "CloudFront distribution ARN for custom domain"
  value       = try(aws_cognito_user_pool_domain.this[0].cloudfront_distribution_arn, null)
}

#==============================================================================
# CLIENT OUTPUTS
#==============================================================================
output "client_ids" {
  description = "Map of client names to IDs"
  value       = { for k, v in aws_cognito_user_pool_client.this : k => v.id }
}
