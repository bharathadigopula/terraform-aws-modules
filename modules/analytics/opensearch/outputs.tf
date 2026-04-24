#==============================================================================
# DOMAIN OUTPUTS
#==============================================================================
output "domain_id" {
  description = "ID of the OpenSearch domain"
  value       = aws_opensearch_domain.this.domain_id
}

output "domain_arn" {
  description = "ARN of the OpenSearch domain"
  value       = aws_opensearch_domain.this.arn
}

output "endpoint" {
  description = "Domain endpoint"
  value       = aws_opensearch_domain.this.endpoint
}

output "dashboard_endpoint" {
  description = "Dashboard endpoint"
  value       = aws_opensearch_domain.this.dashboard_endpoint
}
