#==============================================================================
# DETECTIVE GRAPH
#==============================================================================
resource "aws_detective_graph" "this" {
  tags = var.tags
}

#==============================================================================
# DETECTIVE MEMBERS
#==============================================================================
resource "aws_detective_member" "this" {
  for_each = { for m in var.member_accounts : m.account_id => m }

  account_id                 = each.value.account_id
  email_address              = each.value.email
  graph_arn                  = aws_detective_graph.this.graph_arn
  disable_email_notification = each.value.disable_email_notification
  message                    = each.value.message
}

#==============================================================================
# ORGANIZATION ADMIN
#==============================================================================
resource "aws_detective_organization_admin_account" "this" {
  count = var.admin_account_id != null ? 1 : 0

  account_id = var.admin_account_id
}
