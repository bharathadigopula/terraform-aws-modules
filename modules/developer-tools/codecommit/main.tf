#==============================================================================
# CODECOMMIT REPOSITORIES
#==============================================================================

resource "aws_codecommit_repository" "this" {
  for_each = { for repository in var.repositories : repository.name => repository }

  repository_name = each.value.name
  description     = each.value.description
  default_branch  = each.value.default_branch
  kms_key_id      = each.value.kms_key_id
  tags            = merge(var.tags, each.value.tags)
}

#==============================================================================
# CODECOMMIT TRIGGERS
#==============================================================================

resource "aws_codecommit_trigger" "this" {
  for_each = { for repository in var.repositories : repository.name => repository if length(repository.triggers) > 0 }

  repository_name = aws_codecommit_repository.this[each.key].repository_name

  dynamic "trigger" {
    for_each = each.value.triggers

    content {
      name            = trigger.value.name
      destination_arn = trigger.value.destination_arn
      events          = trigger.value.events
      branches        = trigger.value.branches
      custom_data     = trigger.value.custom_data
    }
  }
}
