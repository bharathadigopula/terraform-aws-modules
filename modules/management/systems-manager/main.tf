#==============================================================================
# SSM PARAMETER STORE
#==============================================================================
resource "aws_ssm_parameter" "this" {
  for_each = { for p in var.parameters : p.name => p }

  name            = each.value.name
  description     = each.value.description
  type            = each.value.type
  value           = each.value.value
  key_id          = each.value.kms_key_id
  tier            = each.value.tier
  allowed_pattern = each.value.allowed_pattern
  data_type       = each.value.data_type

  tags = merge(var.tags, each.value.tags)
}

#==============================================================================
# SSM DOCUMENT
#==============================================================================
resource "aws_ssm_document" "this" {
  for_each = { for d in var.documents : d.name => d }

  name            = each.value.name
  document_type   = each.value.document_type
  document_format = each.value.document_format
  content         = each.value.content
  target_type     = each.value.target_type

  tags = merge(var.tags, each.value.tags)
}

#==============================================================================
# SSM MAINTENANCE WINDOW
#==============================================================================
resource "aws_ssm_maintenance_window" "this" {
  for_each = { for w in var.maintenance_windows : w.name => w }

  name                       = each.value.name
  description                = each.value.description
  schedule                   = each.value.schedule
  schedule_timezone          = each.value.schedule_timezone
  duration                   = each.value.duration
  cutoff                     = each.value.cutoff
  allow_unassociated_targets = each.value.allow_unassociated_targets
  enabled                    = each.value.enabled

  tags = merge(var.tags, each.value.tags)
}

#==============================================================================
# SSM MAINTENANCE WINDOW TARGET
#==============================================================================
resource "aws_ssm_maintenance_window_target" "this" {
  for_each = { for t in var.maintenance_window_targets : t.name => t }

  window_id     = aws_ssm_maintenance_window.this[each.value.window_name].id
  name          = each.value.name
  description   = each.value.description
  resource_type = each.value.resource_type

  targets {
    key    = each.value.target_key
    values = each.value.target_values
  }
}

#==============================================================================
# SSM ASSOCIATION
#==============================================================================
resource "aws_ssm_association" "this" {
  for_each = { for a in var.associations : a.name => a }

  name                = each.value.document_name
  association_name    = each.value.name
  schedule_expression = each.value.schedule_expression
  parameters          = each.value.parameters
  max_concurrency     = each.value.max_concurrency
  max_errors          = each.value.max_errors
  compliance_severity = each.value.compliance_severity

  dynamic "targets" {
    for_each = each.value.targets
    content {
      key    = targets.value.key
      values = targets.value.values
    }
  }
}
