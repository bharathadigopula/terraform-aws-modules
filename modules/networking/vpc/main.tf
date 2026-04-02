#==============================================================================
# VPC
#==============================================================================

resource "aws_vpc" "this" {
  cidr_block                       = var.cidr_block
  instance_tenancy                 = var.instance_tenancy
  enable_dns_support               = var.enable_dns_support
  enable_dns_hostnames             = var.enable_dns_hostnames
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block

  tags = merge(
    var.tags,
    var.vpc_tags,
    { Name = var.name }
  )
}

#==============================================================================
# SECONDARY CIDR BLOCKS
#==============================================================================

resource "aws_vpc_ipv4_cidr_block_association" "this" {
  count = length(var.secondary_cidr_blocks)

  vpc_id     = aws_vpc.this.id
  cidr_block = var.secondary_cidr_blocks[count.index]
}

#==============================================================================
# INTERNET GATEWAY
#==============================================================================

resource "aws_internet_gateway" "this" {
  count = var.create_igw ? 1 : 0

  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags,
    var.igw_tags,
    { Name = "${var.name}-igw" }
  )
}

#==============================================================================
# DHCP OPTIONS
#==============================================================================

resource "aws_vpc_dhcp_options" "this" {
  count = var.enable_dhcp_options ? 1 : 0

  domain_name          = var.dhcp_options_domain_name
  domain_name_servers  = var.dhcp_options_domain_name_servers
  ntp_servers          = var.dhcp_options_ntp_servers
  netbios_name_servers = var.dhcp_options_netbios_name_servers
  netbios_node_type    = var.dhcp_options_netbios_node_type

  tags = merge(
    var.tags,
    { Name = "${var.name}-dhcp" }
  )
}

resource "aws_vpc_dhcp_options_association" "this" {
  count = var.enable_dhcp_options ? 1 : 0

  vpc_id          = aws_vpc.this.id
  dhcp_options_id = aws_vpc_dhcp_options.this[0].id
}

#==============================================================================
# VPC FLOW LOGS
#==============================================================================

resource "aws_cloudwatch_log_group" "flow_log" {
  count = var.enable_flow_log && var.create_flow_log_cloudwatch_log_group ? 1 : 0

  name              = "/aws/vpc-flow-log/${aws_vpc.this.id}"
  retention_in_days = var.flow_log_cloudwatch_log_group_retention
  kms_key_id        = var.flow_log_cloudwatch_log_group_kms_key_id

  tags = merge(
    var.tags,
    { Name = "${var.name}-flow-log" }
  )
}

resource "aws_flow_log" "this" {
  count = var.enable_flow_log ? 1 : 0

  vpc_id                   = aws_vpc.this.id
  traffic_type             = var.flow_log_traffic_type
  log_destination_type     = var.flow_log_destination_type
  max_aggregation_interval = var.flow_log_max_aggregation_interval
  iam_role_arn             = var.flow_log_destination_type == "cloud-watch-logs" ? var.flow_log_iam_role_arn : null

  log_destination = var.create_flow_log_cloudwatch_log_group ? aws_cloudwatch_log_group.flow_log[0].arn : var.flow_log_destination_arn

  tags = merge(
    var.tags,
    { Name = "${var.name}-flow-log" }
  )
}

#==============================================================================
# DEFAULT SECURITY GROUP
#==============================================================================

resource "aws_default_security_group" "this" {
  count = var.manage_default_security_group ? 1 : 0

  vpc_id = aws_vpc.this.id

  dynamic "ingress" {
    for_each = var.default_security_group_ingress
    content {
      self             = lookup(ingress.value, "self", null)
      cidr_blocks      = compact(split(",", lookup(ingress.value, "cidr_blocks", "")))
      ipv6_cidr_blocks = compact(split(",", lookup(ingress.value, "ipv6_cidr_blocks", "")))
      prefix_list_ids  = compact(split(",", lookup(ingress.value, "prefix_list_ids", "")))
      security_groups  = compact(split(",", lookup(ingress.value, "security_groups", "")))
      description      = lookup(ingress.value, "description", null)
      from_port        = lookup(ingress.value, "from_port", 0)
      to_port          = lookup(ingress.value, "to_port", 0)
      protocol         = lookup(ingress.value, "protocol", "-1")
    }
  }

  dynamic "egress" {
    for_each = var.default_security_group_egress
    content {
      self             = lookup(egress.value, "self", null)
      cidr_blocks      = compact(split(",", lookup(egress.value, "cidr_blocks", "")))
      ipv6_cidr_blocks = compact(split(",", lookup(egress.value, "ipv6_cidr_blocks", "")))
      prefix_list_ids  = compact(split(",", lookup(egress.value, "prefix_list_ids", "")))
      security_groups  = compact(split(",", lookup(egress.value, "security_groups", "")))
      description      = lookup(egress.value, "description", null)
      from_port        = lookup(egress.value, "from_port", 0)
      to_port          = lookup(egress.value, "to_port", 0)
      protocol         = lookup(egress.value, "protocol", "-1")
    }
  }

  tags = merge(
    var.tags,
    { Name = "${var.name}-default-sg" }
  )
}

#==============================================================================
# DEFAULT NETWORK ACL
#==============================================================================

resource "aws_default_network_acl" "this" {
  count = var.manage_default_network_acl ? 1 : 0

  default_network_acl_id = aws_vpc.this.default_network_acl_id

  dynamic "ingress" {
    for_each = var.default_network_acl_ingress
    content {
      rule_no    = ingress.value.rule_no
      action     = ingress.value.action
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
      protocol   = ingress.value.protocol
      cidr_block = ingress.value.cidr_block
    }
  }

  dynamic "egress" {
    for_each = var.default_network_acl_egress
    content {
      rule_no    = egress.value.rule_no
      action     = egress.value.action
      from_port  = egress.value.from_port
      to_port    = egress.value.to_port
      protocol   = egress.value.protocol
      cidr_block = egress.value.cidr_block
    }
  }

  tags = merge(
    var.tags,
    { Name = "${var.name}-default-nacl" }
  )

  lifecycle {
    ignore_changes = [subnet_ids]
  }
}
