#==============================================================================
# AWS ORGANIZATION
#==============================================================================
resource "aws_organizations_organization" "this" {
  count = var.create_organization ? 1 : 0

  aws_service_access_principals = var.aws_service_access_principals
  enabled_policy_types          = var.enabled_policy_types
  feature_set                   = var.feature_set
}

#==============================================================================
# ORGANIZATIONAL UNITS
#==============================================================================
resource "aws_organizations_organizational_unit" "this" {
  for_each = { for ou in var.organizational_units : ou.name => ou }

  name      = each.value.name
  parent_id = each.value.parent_id != null ? each.value.parent_id : (var.create_organization ? aws_organizations_organization.this[0].roots[0].id : var.root_id)

  tags = merge(var.tags, each.value.tags)
}

#==============================================================================
# ACCOUNTS
#==============================================================================
resource "aws_organizations_account" "this" {
  for_each = { for a in var.accounts : a.name => a }

  name      = each.value.name
  email     = each.value.email
  parent_id = each.value.parent_id
  role_name = each.value.role_name

  iam_user_access_to_billing = each.value.iam_user_access_to_billing
  close_on_deletion          = each.value.close_on_deletion

  tags = merge(var.tags, each.value.tags)

  lifecycle {
    ignore_changes = [role_name]
  }
}

#==============================================================================
# SERVICE CONTROL POLICIES
#==============================================================================
resource "aws_organizations_policy" "this" {
  for_each = { for p in var.policies : p.name => p }

  name        = each.value.name
  description = each.value.description
  type        = each.value.type
  content     = each.value.content

  tags = merge(var.tags, each.value.tags)
}

#==============================================================================
# POLICY ATTACHMENTS
#==============================================================================
resource "aws_organizations_policy_attachment" "this" {
  for_each = {
    for item in flatten([
      for p in var.policies : [
        for target in p.target_ids : {
          key       = "${p.name}-${target}"
          policy_id = aws_organizations_policy.this[p.name].id
          target_id = target
        }
      ]
    ]) : item.key => item
  }

  policy_id = each.value.policy_id
  target_id = each.value.target_id
}
