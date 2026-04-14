#==============================================================================
# PERMISSION SETS
#==============================================================================
resource "aws_ssoadmin_permission_set" "this" {
  for_each = { for ps in var.permission_sets : ps.name => ps }

  instance_arn     = var.instance_arn
  name             = each.value.name
  description      = each.value.description
  session_duration = each.value.session_duration
  relay_state      = each.value.relay_state

  tags = merge(var.tags, each.value.tags)
}

#==============================================================================
# MANAGED POLICY ATTACHMENTS
#==============================================================================
resource "aws_ssoadmin_managed_policy_attachment" "this" {
  for_each = {
    for item in flatten([
      for ps in var.permission_sets : [
        for arn in ps.managed_policy_arns : {
          key     = "${ps.name}-${arn}"
          ps_name = ps.name
          arn     = arn
        }
      ]
    ]) : item.key => item
  }

  instance_arn       = var.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this[each.value.ps_name].arn
  managed_policy_arn = each.value.arn
}

#==============================================================================
# INLINE POLICY
#==============================================================================
resource "aws_ssoadmin_permission_set_inline_policy" "this" {
  for_each = { for ps in var.permission_sets : ps.name => ps if ps.inline_policy != null }

  instance_arn       = var.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this[each.key].arn
  inline_policy      = each.value.inline_policy
}

#==============================================================================
# ACCOUNT ASSIGNMENTS
#==============================================================================
resource "aws_ssoadmin_account_assignment" "this" {
  for_each = {
    for a in var.account_assignments :
    "${a.permission_set_name}-${a.principal_type}-${a.principal_id}-${a.target_id}" => a
  }

  instance_arn       = var.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this[each.value.permission_set_name].arn
  principal_type     = each.value.principal_type
  principal_id       = each.value.principal_id
  target_id          = each.value.target_id
  target_type        = "AWS_ACCOUNT"
}
