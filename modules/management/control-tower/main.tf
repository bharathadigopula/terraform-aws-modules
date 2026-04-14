#==============================================================================
# CONTROL TOWER LANDING ZONE
#==============================================================================
resource "aws_controltower_landing_zone" "this" {
  count = var.create_landing_zone ? 1 : 0

  manifest_json = var.manifest_json
  version       = var.landing_zone_version

  tags = var.tags
}

#==============================================================================
# CONTROL TOWER CONTROLS (GUARDRAILS)
#==============================================================================
resource "aws_controltower_control" "this" {
  for_each = { for c in var.controls : "${c.control_identifier}-${c.target_identifier}" => c }

  control_identifier = each.value.control_identifier
  target_identifier  = each.value.target_identifier

  dynamic "parameters" {
    for_each = each.value.parameters
    content {
      key   = parameters.value.key
      value = parameters.value.value
    }
  }
}
