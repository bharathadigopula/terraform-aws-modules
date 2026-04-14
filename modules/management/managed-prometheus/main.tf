#==============================================================================
# MANAGED PROMETHEUS WORKSPACE
#==============================================================================
resource "aws_prometheus_workspace" "this" {
  alias       = var.alias
  kms_key_arn = var.kms_key_arn

  logging_configuration {
    log_group_arn = var.log_group_arn
  }

  tags = var.tags
}

#==============================================================================
# ALERT MANAGER DEFINITION
#==============================================================================
resource "aws_prometheus_alert_manager_definition" "this" {
  count = var.alert_manager_definition != null ? 1 : 0

  workspace_id = aws_prometheus_workspace.this.id
  definition   = var.alert_manager_definition
}

#==============================================================================
# RULE GROUP NAMESPACE
#==============================================================================
resource "aws_prometheus_rule_group_namespace" "this" {
  for_each = { for r in var.rule_group_namespaces : r.name => r }

  name         = each.value.name
  workspace_id = aws_prometheus_workspace.this.id
  data         = each.value.data
}
