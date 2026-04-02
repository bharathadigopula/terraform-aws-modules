#==============================================================================
# MERGE RULE SETS
#==============================================================================

locals {
  ingress_rules = concat(
    var.ingress_rules,
    [for rule in var.ingress_with_cidr_blocks : {
      from_port                = rule.from_port
      to_port                  = rule.to_port
      protocol                 = rule.protocol
      cidr_blocks              = rule.cidr_blocks
      ipv6_cidr_blocks         = []
      source_security_group_id = null
      self                     = false
      description              = rule.description
    }]
  )

  egress_rules = concat(
    var.egress_rules,
    [for rule in var.egress_with_cidr_blocks : {
      from_port                = rule.from_port
      to_port                  = rule.to_port
      protocol                 = rule.protocol
      cidr_blocks              = rule.cidr_blocks
      ipv6_cidr_blocks         = []
      source_security_group_id = null
      self                     = false
      description              = rule.description
    }]
  )
}

#==============================================================================
# SECURITY GROUP
#==============================================================================

resource "aws_security_group" "this" {
  name        = var.name
  vpc_id      = var.vpc_id
  description = var.description

  dynamic "ingress" {
    for_each = local.ingress_rules

    content {
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      cidr_blocks      = ingress.value.cidr_blocks
      ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks
      security_groups  = ingress.value.source_security_group_id != null ? [ingress.value.source_security_group_id] : []
      self             = ingress.value.self
      description      = ingress.value.description
    }
  }

  dynamic "egress" {
    for_each = local.egress_rules

    content {
      from_port        = egress.value.from_port
      to_port          = egress.value.to_port
      protocol         = egress.value.protocol
      cidr_blocks      = egress.value.cidr_blocks
      ipv6_cidr_blocks = egress.value.ipv6_cidr_blocks
      security_groups  = egress.value.source_security_group_id != null ? [egress.value.source_security_group_id] : []
      self             = egress.value.self
      description      = egress.value.description
    }
  }

  tags = merge(
    { Name = var.name },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
  }
}
