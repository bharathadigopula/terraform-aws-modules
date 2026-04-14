#==============================================================================
# TRUSTED ADVISOR ORGANIZATION ACCESS
#==============================================================================
resource "aws_trustedadvisor_organization_access" "this" {
  count = var.enable_organization_access ? 1 : 0
}
