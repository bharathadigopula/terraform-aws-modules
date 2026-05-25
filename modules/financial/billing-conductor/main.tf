#==============================================================================
# BILLING CONDUCTOR CLOUD CONTROL RESOURCES
#==============================================================================

resource "aws_cloudcontrolapi_resource" "this" {
  for_each = { for resource in var.resources : resource.name => resource }

  type_name       = each.value.type_name
  desired_state   = jsonencode(each.value.desired_state)
  role_arn        = each.value.role_arn
  type_version_id = each.value.type_version_id

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []

    content {
      create = timeouts.value.create
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
