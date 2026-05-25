#==============================================================================
# FIS EXPERIMENT TEMPLATES
#==============================================================================

resource "aws_fis_experiment_template" "this" {
  for_each = { for template in var.experiment_templates : template.name => template }

  description = each.value.description
  role_arn    = each.value.role_arn
  tags        = merge(var.tags, each.value.tags)

  dynamic "action" {
    for_each = each.value.actions

    content {
      name        = action.value.name
      action_id   = action.value.action_id
      description = action.value.description
      start_after = action.value.start_after

      dynamic "parameter" {
        for_each = action.value.parameters

        content {
          key   = parameter.key
          value = parameter.value
        }
      }

      dynamic "target" {
        for_each = action.value.target != null ? [action.value.target] : []

        content {
          key   = target.value.key
          value = target.value.value
        }
      }
    }
  }

  dynamic "target" {
    for_each = each.value.targets

    content {
      name           = target.value.name
      resource_type  = target.value.resource_type
      selection_mode = target.value.selection_mode
      resource_arns  = target.value.resource_arns
      parameters     = target.value.parameters

      dynamic "filter" {
        for_each = target.value.filters

        content {
          path   = filter.value.path
          values = filter.value.values
        }
      }

      dynamic "resource_tag" {
        for_each = target.value.resource_tags

        content {
          key   = resource_tag.key
          value = resource_tag.value
        }
      }
    }
  }

  dynamic "stop_condition" {
    for_each = each.value.stop_conditions

    content {
      source = stop_condition.value.source
      value  = stop_condition.value.value
    }
  }
}
