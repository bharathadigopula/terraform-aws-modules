#==============================================================================
# LEX BOTS
#==============================================================================

resource "aws_lexv2models_bot" "this" {
  for_each = { for bot in var.bots : bot.name => bot }

  name                        = each.value.name
  role_arn                    = each.value.role_arn
  idle_session_ttl_in_seconds = each.value.idle_session_ttl_in_seconds
  description                 = each.value.description
  type                        = each.value.type
  tags                        = merge(var.tags, each.value.tags)
  test_bot_alias_tags         = merge(var.tags, each.value.test_bot_alias_tags)

  data_privacy {
    child_directed = each.value.child_directed
  }

  dynamic "members" {
    for_each = each.value.members

    content {
      id         = members.value.id
      name       = members.value.name
      alias_id   = members.value.alias_id
      alias_name = members.value.alias_name
      version    = members.value.version
    }
  }
}
