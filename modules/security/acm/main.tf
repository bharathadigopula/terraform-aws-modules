#==============================================================================
# ACM CERTIFICATE
#==============================================================================
resource "aws_acm_certificate" "this" {
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = var.validation_method
  key_algorithm             = var.key_algorithm

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

#==============================================================================
# CERTIFICATE VALIDATION
#==============================================================================
resource "aws_acm_certificate_validation" "this" {
  count = var.wait_for_validation ? 1 : 0

  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = var.validation_record_fqdns
}
