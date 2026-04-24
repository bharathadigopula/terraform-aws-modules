#==============================================================================
# TRUSTED ADVISOR ORGANIZATIONAL VIEW
#==============================================================================
resource "aws_trustedadvisor_organizational_view" "this" {
  count = var.enable_organizational_view ? 1 : 0
}
