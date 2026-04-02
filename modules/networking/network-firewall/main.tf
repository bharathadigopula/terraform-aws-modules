#==============================================================================
# NETWORK FIREWALL
#==============================================================================

resource "aws_networkfirewall_firewall" "this" {
  name                              = var.name
  description                       = var.description
  vpc_id                            = var.vpc_id
  firewall_policy_arn               = aws_networkfirewall_firewall_policy.this.arn
  delete_protection                 = var.delete_protection
  firewall_policy_change_protection = var.firewall_policy_change_protection
  subnet_change_protection          = var.subnet_change_protection

  dynamic "subnet_mapping" {
    for_each = var.subnet_mapping
    content {
      subnet_id = subnet_mapping.value.subnet_id
    }
  }

  tags = merge(
    var.tags,
    { Name = var.name }
  )
}

#==============================================================================
# FIREWALL POLICY
#==============================================================================

resource "aws_networkfirewall_firewall_policy" "this" {
  name        = var.policy_name != "" ? var.policy_name : "${var.name}-policy"
  description = var.policy_description

  firewall_policy {
    stateless_default_actions          = var.stateless_default_actions
    stateless_fragment_default_actions = var.stateless_fragment_default_actions

    dynamic "stateful_rule_group_reference" {
      for_each = var.stateful_rule_group_references
      content {
        priority     = stateful_rule_group_reference.value.priority
        resource_arn = stateful_rule_group_reference.value.resource_arn
      }
    }

    dynamic "stateful_rule_group_reference" {
      for_each = aws_networkfirewall_rule_group.stateful
      content {
        priority     = 100 + index(keys(aws_networkfirewall_rule_group.stateful), stateful_rule_group_reference.key)
        resource_arn = stateful_rule_group_reference.value.arn
      }
    }

    dynamic "stateless_rule_group_reference" {
      for_each = var.stateless_rule_group_references
      content {
        priority     = stateless_rule_group_reference.value.priority
        resource_arn = stateless_rule_group_reference.value.resource_arn
      }
    }

    dynamic "stateless_rule_group_reference" {
      for_each = aws_networkfirewall_rule_group.stateless
      content {
        priority     = var.stateless_rule_groups[index(keys(aws_networkfirewall_rule_group.stateless), stateless_rule_group_reference.key)].priority
        resource_arn = stateless_rule_group_reference.value.arn
      }
    }
  }

  tags = merge(
    var.tags,
    { Name = var.policy_name != "" ? var.policy_name : "${var.name}-policy" }
  )
}

#==============================================================================
# STATEFUL RULE GROUPS (SURICATA)
#==============================================================================

resource "aws_networkfirewall_rule_group" "stateful" {
  for_each = { for idx, rg in var.stateful_rule_groups : rg.name => rg }

  name        = each.value.name
  capacity    = each.value.capacity
  type        = "STATEFUL"
  description = "Stateful rule group: ${each.value.name}"

  rules = each.value.rules_string

  tags = merge(
    var.tags,
    { Name = each.value.name }
  )
}

#==============================================================================
# STATELESS RULE GROUPS
#==============================================================================

resource "aws_networkfirewall_rule_group" "stateless" {
  for_each = { for idx, rg in var.stateless_rule_groups : rg.name => rg }

  name        = each.value.name
  capacity    = each.value.capacity
  type        = "STATELESS"
  description = "Stateless rule group: ${each.value.name}"

  rule_group {
    rules_source {
      stateless_rules_and_custom_actions {
        dynamic "stateless_rule" {
          for_each = each.value.rules
          content {
            priority = stateless_rule.value.priority

            rule_definition {
              actions = stateless_rule.value.actions

              match_attributes {
                dynamic "source" {
                  for_each = stateless_rule.value.match_attributes.source_cidrs
                  content {
                    address_definition = source.value
                  }
                }

                dynamic "destination" {
                  for_each = stateless_rule.value.match_attributes.destination_cidrs
                  content {
                    address_definition = destination.value
                  }
                }

                dynamic "source_port" {
                  for_each = stateless_rule.value.match_attributes.source_ports
                  content {
                    from_port = source_port.value.from_port
                    to_port   = source_port.value.to_port
                  }
                }

                dynamic "destination_port" {
                  for_each = stateless_rule.value.match_attributes.destination_ports
                  content {
                    from_port = destination_port.value.from_port
                    to_port   = destination_port.value.to_port
                  }
                }

                protocols = stateless_rule.value.match_attributes.protocols
              }
            }
          }
        }
      }
    }
  }

  tags = merge(
    var.tags,
    { Name = each.value.name }
  )
}

#==============================================================================
# LOGGING CONFIGURATION
#==============================================================================

resource "aws_networkfirewall_logging_configuration" "this" {
  count = length(var.logging_configuration) > 0 ? 1 : 0

  firewall_arn = aws_networkfirewall_firewall.this.arn

  logging_configuration {
    dynamic "log_destination_config" {
      for_each = var.logging_configuration
      content {
        log_destination_type = log_destination_config.value.log_destination_type
        log_type             = log_destination_config.value.log_type
        log_destination      = log_destination_config.value.log_destination
      }
    }
  }
}
