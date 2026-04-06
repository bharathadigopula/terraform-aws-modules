#==============================================================================
# AWS BACKUP VAULT
#==============================================================================
resource "aws_backup_vault" "this" {
  name          = var.vault_name
  kms_key_arn   = var.kms_key_arn
  force_destroy = var.force_destroy_vault
  tags          = var.tags
}

#==============================================================================
# AWS BACKUP PLAN
#==============================================================================
resource "aws_backup_plan" "this" {
  name = var.plan_name

  dynamic "rule" {
    for_each = var.plan_rules
    content {
      rule_name                = rule.value.rule_name
      target_vault_name        = rule.value.target_vault_name
      schedule                 = rule.value.schedule
      start_window             = rule.value.start_window
      completion_window        = rule.value.completion_window
      enable_continuous_backup = rule.value.enable_continuous_backup

      dynamic "lifecycle" {
        for_each = rule.value.lifecycle != null ? [rule.value.lifecycle] : []
        content {
          cold_storage_after = lifecycle.value.cold_storage_after
          delete_after       = lifecycle.value.delete_after
        }
      }

      dynamic "copy_action" {
        for_each = rule.value.copy_action != null ? rule.value.copy_action : []
        content {
          destination_vault_arn = copy_action.value.destination_vault_arn

          dynamic "lifecycle" {
            for_each = copy_action.value.lifecycle != null ? [copy_action.value.lifecycle] : []
            content {
              cold_storage_after = lifecycle.value.cold_storage_after
              delete_after       = lifecycle.value.delete_after
            }
          }
        }
      }
    }
  }

  tags = var.tags
}

#==============================================================================
# AWS BACKUP SELECTION
#==============================================================================
resource "aws_backup_selection" "this" {
  name         = var.selection_name
  iam_role_arn = var.selection_iam_role_arn
  plan_id      = aws_backup_plan.this.id
  resources    = var.selection_resources

  dynamic "condition" {
    for_each = (
      length(var.selection_conditions.string_equals) > 0 ||
      length(var.selection_conditions.string_not_equals) > 0 ||
      length(var.selection_conditions.string_like) > 0 ||
      length(var.selection_conditions.string_not_like) > 0
    ) ? [var.selection_conditions] : []

    content {
      dynamic "string_equals" {
        for_each = condition.value.string_equals
        content {
          key   = string_equals.value.key
          value = string_equals.value.value
        }
      }

      dynamic "string_not_equals" {
        for_each = condition.value.string_not_equals
        content {
          key   = string_not_equals.value.key
          value = string_not_equals.value.value
        }
      }

      dynamic "string_like" {
        for_each = condition.value.string_like
        content {
          key   = string_like.value.key
          value = string_like.value.value
        }
      }

      dynamic "string_not_like" {
        for_each = condition.value.string_not_like
        content {
          key   = string_not_like.value.key
          value = string_not_like.value.value
        }
      }
    }
  }

  dynamic "selection_tag" {
    for_each = var.selection_tags
    content {
      type  = selection_tag.value.type
      key   = selection_tag.value.key
      value = selection_tag.value.value
    }
  }
}
