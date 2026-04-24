#==============================================================================
# DATAZONE DOMAIN
#==============================================================================
resource "aws_datazone_domain" "this" {
  name                  = var.name
  description           = var.description
  domain_execution_role = var.domain_execution_role
  kms_key_identifier    = var.kms_key_identifier

  dynamic "single_sign_on" {
    for_each = var.single_sign_on_type != null ? [1] : []
    content {
      type            = var.single_sign_on_type
      user_assignment = var.single_sign_on_user_assignment
    }
  }

  tags = var.tags
}

#==============================================================================
# DATAZONE PROJECT
#==============================================================================
resource "aws_datazone_project" "this" {
  for_each = { for p in var.projects : p.name => p }

  domain_identifier   = aws_datazone_domain.this.id
  name                = each.value.name
  description         = each.value.description
  glossary_terms      = each.value.glossary_terms
  skip_deletion_check = each.value.skip_deletion_check
}
