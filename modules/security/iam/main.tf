#==============================================================================
# IAM ROLE
#==============================================================================
resource "aws_iam_role" "this" {
  for_each = { for r in var.roles : r.name => r }

  name                  = each.value.name
  path                  = each.value.path
  description           = each.value.description
  assume_role_policy    = each.value.assume_role_policy
  max_session_duration  = each.value.max_session_duration
  force_detach_policies = each.value.force_detach_policies
  permissions_boundary  = each.value.permissions_boundary

  tags = merge(var.tags, each.value.tags)
}

#==============================================================================
# IAM ROLE MANAGED POLICY ATTACHMENTS
#==============================================================================
resource "aws_iam_role_policy_attachment" "this" {
  for_each = {
    for item in flatten([
      for r in var.roles : [
        for arn in r.managed_policy_arns : {
          key        = "${r.name}-${arn}"
          role_name  = r.name
          policy_arn = arn
        }
      ]
    ]) : item.key => item
  }

  role       = aws_iam_role.this[each.value.role_name].name
  policy_arn = each.value.policy_arn
}

#==============================================================================
# IAM ROLE INLINE POLICIES
#==============================================================================
resource "aws_iam_role_policy" "this" {
  for_each = {
    for item in flatten([
      for r in var.roles : [
        for name, policy in r.inline_policies : {
          key       = "${r.name}-${name}"
          role_name = r.name
          name      = name
          policy    = policy
        }
      ]
    ]) : item.key => item
  }

  name   = each.value.name
  role   = aws_iam_role.this[each.value.role_name].name
  policy = each.value.policy
}

#==============================================================================
# IAM INSTANCE PROFILE
#==============================================================================
resource "aws_iam_instance_profile" "this" {
  for_each = { for r in var.roles : r.name => r if r.create_instance_profile }

  name = each.value.name
  role = aws_iam_role.this[each.key].name

  tags = merge(var.tags, each.value.tags)
}

#==============================================================================
# IAM POLICY
#==============================================================================
resource "aws_iam_policy" "this" {
  for_each = { for p in var.policies : p.name => p }

  name        = each.value.name
  path        = each.value.path
  description = each.value.description
  policy      = each.value.policy

  tags = merge(var.tags, each.value.tags)
}

#==============================================================================
# IAM USER
#==============================================================================
resource "aws_iam_user" "this" {
  for_each = { for u in var.users : u.name => u }

  name                 = each.value.name
  path                 = each.value.path
  force_destroy        = each.value.force_destroy
  permissions_boundary = each.value.permissions_boundary

  tags = merge(var.tags, each.value.tags)
}

#==============================================================================
# IAM USER POLICY ATTACHMENT
#==============================================================================
resource "aws_iam_user_policy_attachment" "this" {
  for_each = {
    for item in flatten([
      for u in var.users : [
        for arn in u.policy_arns : {
          key        = "${u.name}-${arn}"
          user_name  = u.name
          policy_arn = arn
        }
      ]
    ]) : item.key => item
  }

  user       = aws_iam_user.this[each.value.user_name].name
  policy_arn = each.value.policy_arn
}

#==============================================================================
# IAM GROUP
#==============================================================================
resource "aws_iam_group" "this" {
  for_each = { for g in var.groups : g.name => g }

  name = each.value.name
  path = each.value.path
}

#==============================================================================
# IAM GROUP POLICY ATTACHMENT
#==============================================================================
resource "aws_iam_group_policy_attachment" "this" {
  for_each = {
    for item in flatten([
      for g in var.groups : [
        for arn in g.policy_arns : {
          key        = "${g.name}-${arn}"
          group_name = g.name
          policy_arn = arn
        }
      ]
    ]) : item.key => item
  }

  group      = aws_iam_group.this[each.value.group_name].name
  policy_arn = each.value.policy_arn
}

#==============================================================================
# IAM GROUP MEMBERSHIP
#==============================================================================
resource "aws_iam_group_membership" "this" {
  for_each = { for g in var.groups : g.name => g if length(g.user_names) > 0 }

  name  = "${each.value.name}-membership"
  group = aws_iam_group.this[each.key].name
  users = each.value.user_names
}
