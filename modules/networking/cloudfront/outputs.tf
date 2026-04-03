#==============================================================================
# DISTRIBUTION OUTPUTS
#==============================================================================

output "distribution_id" {
  description = "ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.this.id
}

output "distribution_arn" {
  description = "ARN of the CloudFront distribution"
  value       = aws_cloudfront_distribution.this.arn
}

output "distribution_domain_name" {
  description = "Domain name of the CloudFront distribution (e.g. d1234.cloudfront.net)"
  value       = aws_cloudfront_distribution.this.domain_name
}

output "distribution_hosted_zone_id" {
  description = "Route 53 hosted zone ID for the CloudFront distribution"
  value       = aws_cloudfront_distribution.this.hosted_zone_id
}

output "distribution_status" {
  description = "Current status of the CloudFront distribution (e.g. Deployed)"
  value       = aws_cloudfront_distribution.this.status
}

#==============================================================================
# ORIGIN ACCESS CONTROL OUTPUTS
#==============================================================================

output "origin_access_control_ids" {
  description = "Map of origin access control names to their IDs"
  value       = { for k, v in aws_cloudfront_origin_access_control.this : k => v.id }
}
