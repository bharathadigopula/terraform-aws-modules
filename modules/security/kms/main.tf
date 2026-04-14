#==============================================================================
# KMS KEY
#==============================================================================
resource "aws_kms_key" "this" {
  description              = var.description
  key_usage                = var.key_usage
  customer_master_key_spec = var.customer_master_key_spec
  deletion_window_in_days  = var.deletion_window_in_days
  is_enabled               = var.is_enabled
  enable_key_rotation      = var.enable_key_rotation
  rotation_period_in_days  = var.rotation_period_in_days
  multi_region             = var.multi_region
  policy                   = var.policy

  tags = var.tags
}

#==============================================================================
# KMS ALIAS
#==============================================================================
resource "aws_kms_alias" "this" {
  for_each = toset(var.aliases)

  name          = "alias/${each.value}"
  target_key_id = aws_kms_key.this.key_id
}

#==============================================================================
# KMS GRANTS
#==============================================================================
resource "aws_kms_grant" "this" {
  for_each = { for g in var.grants : g.name => g }

  name               = each.value.name
  key_id             = aws_kms_key.this.key_id
  grantee_principal  = each.value.grantee_principal
  operations         = each.value.operations
  retiring_principal = each.value.retiring_principal
}
