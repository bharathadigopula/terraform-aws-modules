#==============================================================================
# ACM CERTIFICATE OUTPUTS
#==============================================================================
output "certificate_arn" {
  description = "ARN of the certificate"
  value       = aws_acm_certificate.this.arn
}

output "certificate_domain_name" {
  description = "Domain name of the certificate"
  value       = aws_acm_certificate.this.domain_name
}

output "domain_validation_options" {
  description = "Domain validation options for DNS validation"
  value       = aws_acm_certificate.this.domain_validation_options
}

output "certificate_status" {
  description = "Status of the certificate"
  value       = aws_acm_certificate.this.status
}
