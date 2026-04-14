#==============================================================================
# AUDIT MANAGER ACCOUNT REGISTRATION
#==============================================================================
resource "aws_auditmanager_account_registration" "this" {
  kms_key                 = var.kms_key_arn
  delegated_admin_account = var.delegated_admin_account
}

#==============================================================================
# CUSTOM FRAMEWORK
#==============================================================================
resource "aws_auditmanager_framework" "this" {
  for_each = { for f in var.frameworks : f.name => f }

  name            = each.value.name
  description     = each.value.description
  compliance_type = each.value.compliance_type

  dynamic "control_sets" {
    for_each = each.value.control_sets
    content {
      name = control_sets.value.name

      dynamic "controls" {
        for_each = control_sets.value.control_ids
        content {
          id = controls.value
        }
      }
    }
  }

  tags = merge(var.tags, each.value.tags)

  depends_on = [aws_auditmanager_account_registration.this]
}

#==============================================================================
# ASSESSMENT
#==============================================================================
resource "aws_auditmanager_assessment" "this" {
  for_each = { for a in var.assessments : a.name => a }

  name         = each.value.name
  description  = each.value.description
  framework_id = each.value.framework_id

  roles {
    role_arn  = each.value.role_arn
    role_type = each.value.role_type
  }

  scope {
    dynamic "aws_accounts" {
      for_each = each.value.aws_account_ids
      content {
        id = aws_accounts.value
      }
    }

    dynamic "aws_services" {
      for_each = each.value.aws_services
      content {
        service_name = aws_services.value
      }
    }
  }

  assessment_reports_destination {
    destination      = each.value.reports_s3_destination
    destination_type = "S3"
  }

  tags = merge(var.tags, each.value.tags)

  depends_on = [aws_auditmanager_account_registration.this]
}
