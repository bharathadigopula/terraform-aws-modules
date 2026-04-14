#==============================================================================
# SECURITY HUB ACCOUNT
#==============================================================================
resource "aws_securityhub_account" "this" {
  enable_default_standards  = var.enable_default_standards
  control_finding_generator = var.control_finding_generator
  auto_enable_controls      = var.auto_enable_controls
}

#==============================================================================
# SECURITY HUB STANDARDS
#==============================================================================
resource "aws_securityhub_standards_subscription" "this" {
  for_each = toset(var.standards_arns)

  standards_arn = each.value

  depends_on = [aws_securityhub_account.this]
}

#==============================================================================
# SECURITY HUB PRODUCT SUBSCRIPTIONS
#==============================================================================
resource "aws_securityhub_product_subscription" "this" {
  for_each = toset(var.product_arns)

  product_arn = each.value

  depends_on = [aws_securityhub_account.this]
}

#==============================================================================
# ORGANIZATION ADMIN
#==============================================================================
resource "aws_securityhub_organization_admin_account" "this" {
  count = var.admin_account_id != null ? 1 : 0

  admin_account_id = var.admin_account_id

  depends_on = [aws_securityhub_account.this]
}
