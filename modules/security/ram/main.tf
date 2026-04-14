#==============================================================================
# RAM RESOURCE SHARE
#==============================================================================
resource "aws_ram_resource_share" "this" {
  name                      = var.name
  allow_external_principals = var.allow_external_principals
  permission_arns           = var.permission_arns

  tags = var.tags
}

#==============================================================================
# RESOURCE ASSOCIATIONS
#==============================================================================
resource "aws_ram_resource_association" "this" {
  for_each = toset(var.resource_arns)

  resource_arn       = each.value
  resource_share_arn = aws_ram_resource_share.this.arn
}

#==============================================================================
# PRINCIPAL ASSOCIATIONS
#==============================================================================
resource "aws_ram_principal_association" "this" {
  for_each = toset(var.principal_arns)

  principal          = each.value
  resource_share_arn = aws_ram_resource_share.this.arn
}
